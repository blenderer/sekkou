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