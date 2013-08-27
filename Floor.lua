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
	self.startx = math.ceil(-1 * self.width / 2)
	self.starty = math.ceil(-1 * self.height / 2)

end

function Floor:build()
	--build the first room
	first_room_interface = self:getRandomRI()

	first_room_x = math.ceil(0 - first_room_interface.w / 2)
	first_room_y = math.ceil(0 - first_room_interface.h / 2)

	self:addRoom(first_room_x, first_room_y, first_room_interface)

	--build the rest of the rooms
	for i = 1, self.n - 1 do
		repeat
			rand_interface = self:getRandomRI()
			randx = math.random(self.startx, self.startx + self.width)
			randy = math.random(self.starty, self.starty + self.height)
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

	arb_num = self.n * .55

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
	for y = ymin, ymax do
		line = ""
		for x = xmin, xmax do
			if walkable[x][y] == 0 then
				line = line .. 'X'
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
	newroom = Room:new(0, 0, ri.w, ri.h)

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

function Floor:getClosestRoom(origin_room)
	
end

function Floor:getWalkable()
	xmin, xmax, ymin, ymax = self.tiles:getBounds()

	walkable = {}

	for x = xmin, xmax do
		walkable[x] = {}
		for y = ymin, ymax do
			if self.tiles:get(x, y) then
				if self.tiles:get(x, y):__tostring() == "Tile" then
					walkable[x][y] = 0
				else
					walkable[x][y] = 1
				end
			else
				walkable[x][y] = 1
			end
		end
	end

	return walkable
end