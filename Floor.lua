require 'vendor/middleclass'
require 'vendor/Array2d'
require 'Room'
require 'Corridor'
require 'Tile'

math.randomseed(os.time())

Floor = class('Floor')

function Floor:initialize(room_count, room_interface)
	self.n = room_count
	self.ri = room_interface

	self.tiles = Array2d:new()

	self.rooms = {}
end

function Floor:build()
	--build the first room
	self:addRoom(0, 0)
	self:addRoom(-12, -12)
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

	--this loop builds the rows
	for y = ymin, ymax do
		line = ""
		for x = xmin, xmax do
			if self.tiles:get(x, y) then
				if self.tiles:get(x, y).walkable then
					line = line .. 'X'
				else
					line = line .. ' '
				end
			else
				line = line .. ' '
			end
		end
		print(line .. ' ' .. y)
	end
	
end

function Floor:addRoom(xpos, ypos)
	if #self.ri > 1 then
		room_interface = math.random(1, #self.ri)
	else
		room_interface = 1
	end

	table.insert(self.rooms, Room:new(0, 0, self.ri[room_interface].w, self.ri[room_interface].h))
	for x = 0, self.ri[room_interface].w - 1 do
		for y = 0, self.ri[room_interface].h - 1 do
			tilex = xpos + x
			tiley = ypos + y
			self.tiles:set(tilex, tiley, Tile:new(tilex, tiley, true, self.tiles))
			print("new tile created @: " .. tilex, tiley)
		end
	end
end