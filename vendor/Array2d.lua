Array2d = class('Array2d')

function Array2d:initialize()
	self.grid = {}
	self.bounds = {col_low = 0, col_high = 0, row_low = 0, row_high = 0}
end

function Array2d:get(col, row)
	self:check(col)

	return self.grid[col][row]
end

function Array2d:neighbor(col, row, pos)
	neighbor = nil

	if pos == 'left' then
		self:check(col - 1)
		neighbor = self.grid[col - 1][row]
	elseif pos == 'right' then
		self:check(col + 1)
		neighbor = self.grid[col + 1][row]
	elseif pos == 'top' then
		self:check(col)
		neighbor = self.grid[col][row - 1]
	elseif pos == 'bottom' then
		self:check(col)
		neighbor = self.grid[col][row + 1]
	end

	return neighbor
end

function Array2d:set(col, row, object)
	self:check(col)

	self:compareBounds(col, row)

	self.grid[col][row] = object
end

function Array2d:check(col)
	if type(self.grid[col]) ~= "table" then
		self.grid[col] = {}
	end
end

function Array2d:compareBounds(col, row)
	if col < self.bounds.col_low then
		self.bounds.col_low = col
	end
	if col > self.bounds.col_high then
		self.bounds.col_high = col
	end

	if row < self.bounds.row_low then
		self.bounds.row_low = row
	end
	if row > self.bounds.row_high then
		self.bounds.row_high = row
	end
end

function Array2d:getBounds()
	return self.bounds.col_low, self.bounds.col_high, self.bounds.row_low, self.bounds.row_high
end
