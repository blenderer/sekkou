Room = class('Room')

function Room:initialize(xpos, ypos, width, height)
	self.x = xpos
	self.y = ypos
	self.w = width
	self.h = height
end