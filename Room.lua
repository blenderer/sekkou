Room = class('Room')

function Room:initialize(col, row, width, height)
	self.x = col
	self.y = row
	self.w = width
	self.h = height
	self.tiles = {}
end