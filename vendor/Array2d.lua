Array2d = class('Array2d')

function Array2d:initialize()
	self.grid = {}
	self.bounds = {col_low = 1, col_high = 1, row_low = 1, row_high = 1}
end

function Array2d:get(col, row)
	self:check(col)

	return self.grid[col][row]
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
