Corridor = class('Corridor')

-- Calls the grid class
local Grid = require ("vendor/jumper.grid")
-- Calls the pathfinder class
local Pathfinder = require ("vendor/jumper.pathfinder")

function Corridor:initialize(startx, starty, endx, endy)
	self.sx = startx 
	self.sy = starty 
	self.ex = endx 
	self.ey = endy 
	self.tiles = {}
end

function Corridor:makePath(map, x1, y1, x2, y2)
	grid = Grid(map)

	myFinder = Pathfinder(grid, 'JPS', 0)

	myFinder:setMode('ORTHOGONAL')

	path = myFinder:getPath(x1, y1, x2, y2)
end