Tile = class('Tile')

function Tile:initialize(col, row, grid, tipe)
	self.x = col
	self.y = row
	self.grid = grid

	self.tags = {}

	self.room = nil
	self.type = tipe or "r"
end

function Tile:addTag(newtag)
	table.insert(self.tags, newtag)
end

function Tile:hasTag(searchtag)
	found = false
	for i = 1, #self.tags do
		if self.tags[i] == searchtag then
			found = true
			break
		end
	end

	return found
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