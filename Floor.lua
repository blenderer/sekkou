require 'vendor/middleclass'
require 'vendor/Array2d'
require 'Room'
require 'Corridor'
require 'Tile'

math.randomseed(os.time())

Floor = class('Floor')

function Floor:initialize(room_count, room_distance, room_interface)
	self.n = room_count
	self.ri = room_interface

	self.distance = room_distance

	self.tiles = Array2d:new()

	self.rooms = {}

	self.width, self.height = self:makeBounds()
	self.centerx = math.ceil(self.width / 2)
	self.centery = math.ceil(self.height / 2)
	self.startx = 1
	self.starty = 1

end

function Floor:build()
	--build the rooms
	for i = 1, self.n do
		repeat
			rand_interface = self:getRandomRI()
			randx = math.random(1, self.width)
			randy = math.random(1, self.height)
		until self:isGoodSpot(randx, randy, rand_interface)
		self:addRoom(randx, randy, rand_interface)
	end
	
	--build the corridors

end

function Floor:makeBounds()
	max_width = 0
	max_height = 0

	for i = 1, #self.ri do
		if self.ri[i].w > max_width then
			max_width = self.ri[i].w
		end
		if self.ri[i].h > max_height then
			max_height = self.ri[i].h
		end
	end

	arb_num = self.n * .95

	width = math.ceil(max_width * arb_num)
	height = math.ceil(max_height * arb_num)
	return width, height
end

function Floor:print()
	xmin, xmax, ymin, ymax = self.tiles:getBounds()

	if math.abs(xmax) > math.abs(xmin) then
		largest = math.abs(xmax)
	else
		largest = math.abs(xmin)
	end

	
	--this for loop builds the column headings
	for d = string.len(tostring(largest)), 1, -1 do
		place = "1"
		for i = 1, d - 1 do
			place = place .. "0"
		end
		place = place * 1

		line = ""
		for x = xmin, xmax do
			x = math.abs(x)
			digit = math.floor((x / place) % 10)
			if x == 0 and place == 1 then
				line = line .. x
			elseif x < place then
				line = line .. " "
			else
				line = line .. digit
			end
		end
		print(line)
	end

	walkable = self:getWalkable()

	--this loop builds the rows
	for y = 1, #walkable[1] do
		line = ""
		for x = 1, #walkable do
			if walkable[x][y] == 0 then
				line = line .. 'X'
			elseif walkable[x][y] == 2 then
				line = line .. '-'
			else
				line = line .. ' '
			end
		end
		print(line .. ' ' .. y)
	end
	
end

function Floor:isGoodSpot(xpos, ypos, ri)
	clear = true

	for x = xpos - self.distance, xpos + ri.w - 1 + self.distance do
		for y = ypos - self.distance, ypos + ri.h - 1 + self.distance do
			if self.tiles:get(x,y) then
				clear = false
			end
		end
	end

	return clear
end

function Floor:getRandomRI()
	if #self.ri > 1 then
		room_interface = math.random(1, #self.ri)
	else
		room_interface = 1
	end

	return self.ri[room_interface]
end

function Floor:addRoom(xpos, ypos, ri)
	newroom = Room:new(xpos, ypos, ri.w, ri.h)

	table.insert(self.rooms, newroom)
	for x = 0, ri.w - 1 do
		for y = 0, ri.h - 1 do
			tilex = xpos + x
			tiley = ypos + y

			newtile = Tile:new(tilex, tiley, self.tiles)
			newtile.room = newroom
			table.insert(newroom.tiles, newtile)

			self.tiles:set(tilex, tiley, newtile)
		end
	end
end

function Floor:getUnconnectedRooms()
	unconnectedrooms = {}
	for x = 1, #self.rooms do
		if not self.rooms[x].connected then
			table.insert(unconnectedrooms, self.rooms[x])
		end
	end

	return unconnectedrooms
end

function Floor:getClosestRoom(origin_room)
	
end

function Floor:getWalkable(charmap)
	stringmap = charmap or false

	xmin, xmax, ymin, ymax = self.tiles:getBounds()

	walkable = {}

	startx = 1

	if not stringmap then

		for x = xmin, xmax do
			walkable[startx] = {}

			starty = 1
			for y = ymin, ymax do
				if self.tiles:get(x, y) then
					if self.tiles:get(x, y):__tostring() == "Tile" and self.tiles:get(x, y).type == "r" then
						walkable[startx][starty] = 0
					elseif self.tiles:get(x, y):__tostring() == "Tile" and self.tiles:get(x, y).type == "c" then
						walkable[startx][starty] = 2
					else
						walkable[startx][starty] = 1
					end
				else
					walkable[startx][starty] = 1
				end
				starty = starty + 1
			end
			startx = startx + 1
		end
	else
		dastring = ""

		for y = ymin, ymax do
			for x = xmin, xmax do
				if self.tiles:get(x, y) then
					if self.tiles:get(x, y):__tostring() == "Tile" then
						dastring = dastring .. 0
					else
						dastring = dastring .. 1
					end
				else
					dastring = dastring .. 1
				end
			end
			dastring = dastring .. '\n'
		end
		string.sub(dastring, 1, -2)
		walkable = dastring
	end

	return walkable, xmin, xmax, ymin, ymax
end

function Floor:makeCorridor(x1, y1, x2, y2)
	new_corridor = Corridor:new(x1, y1, x2, y2)
	corridor_nodes = new_corridor:makePath(self:getWalkable(true))
	for i = 1, #corridor_nodes do
		new_tile = Tile:new(corridor_nodes[i].x, corridor_nodes[i].y, self.tiles, "c")
		new_tile:addTag("corridor")
		self.tiles:set(corridor_nodes[i].x, corridor_nodes[i].y, new_tile)
	end
end

function Floor:getClosestFromPoint(xpos, ypos)
	closest_room = nil
	closest_distance = math.huge

	for i = 1, #self.rooms do
		roomx, roomy = self.rooms[i]:getPos()
		distance = math.sqrt(math.pow(roomx - xpos, 2) + math.pow(roomy - ypos, 2))

		if distance < closest_distance then
			closest_room = self.rooms[i]
			closest_distance = distance
		end
	end

	return closest_room
end