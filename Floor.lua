require 'vendor/middleclass'
require 'vendor/Array2d'
require 'Room'
require 'Corridor'

Floor = class('Floor')

function Floor:initialize(room_count, room_interface)
	self.n = room_count
	self.ri = room_interface

	self.tiles = Array2d:new()
end