Room = class('Room')

function Room:initialize(col, row, width, height)
	self.x = col
	self.y = row
	self.w = width
	self.h = height
	self.tiles = {}
	self.connected = false
	self.connected_rooms = {}
end

function Room:getPos()
	--Returns the CENTER of the box, otherwise just use Room.x, Room.y
	return math.floor(self.x + (self.w / 2)), math.floor(self.y + (self.h / 2))
end

function Room:getPerimeterTiles()
	perim_tiles = {}

	for i = 1, #self.tiles do
		this_tile = self.tiles[i] --shortcut variable

		if this_tile.x == self.x or this_tile.x == self.x + (self.w - 1) or this_tile.y  == self.y or this_tile.y == self.y + (self.h - 1) then
			table.insert(perim_tiles, this_tile)
		end
	end

	return perim_tiles
end

function Room:getRanPerimTile()
	perim_tiles = self:getPerimeterTiles()

	return perim_tiles[math.random(#perim_tiles)]
end

--takes a perimeter tile and returns the door tile (sometimes random)
function Room:getNewDoorCoords()
	open_door_tiles = {}
	the_perim_tile = self:getRanPerimTile()

	x = nil
	y = nil

	left = the_perim_tile:getLeft()
	if not left then
		table.insert(open_door_tiles, {the_perim_tile.x - 1, the_perim_tile.y})
	end

	right = the_perim_tile:getRight()
	if not right then
		table.insert(open_door_tiles, {the_perim_tile.x + 1, the_perim_tile.y})
	end

	top = the_perim_tile:getTop()
	if not top then
		table.insert(open_door_tiles, {the_perim_tile.x, the_perim_tile.y - 1})
	end

	bottom = the_perim_tile:getBottom()
	if not bottom then
		table.insert(open_door_tiles, {the_perim_tile.x, the_perim_tile.y + 1})
	end

	select_me = open_door_tiles[math.random(#open_door_tiles)]

	return select_me[1], select_me[2]
end