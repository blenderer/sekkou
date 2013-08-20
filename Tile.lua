Tile = class('Tile')

function Tile:initialize(col, row, walkable, grid)
	self.x = col
	self.y = row
	self.walkable = walkable
	self.grid = grid
end

function Tile:getLeft()
	return self.grid:get(self.x - 1, self.y)
end

function Tile:getTop()
	return self.grid:get(self.x, self.y - 1)
end

function Tile:getRight()
	return self.grid:get(self.x + 1, self.y)
end

function Tile:getBottom()
	return self.grid:get(self.x, self.y + 1)
end