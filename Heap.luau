--!strict

local Heap = {}
Heap.__index = Heap

export type Heap = typeof(setmetatable(
	{} :: {
		Cmp: (parent: any, child: any) -> boolean,
		Heap: {any}
	},
	Heap
	)
)

-- Constructs a new Heap object
-- @param cmpFunc (parent: any, child: any) -> boolean A comparator function that 
-- defines the order of the Heap
-- @param tbl {any}? A table to be heapified
-- @return Heap The new Heap object
function Heap.new(cmpFunc: (parent: any, child: any) -> boolean, tbl: {any}?): Heap
	local self = {
		Cmp = cmpFunc,
		Heap = {}
	}
	
	setmetatable(self, Heap)

	if tbl then
		for _, v in tbl do
			self:Insert(v)
		end
	end
	
	return self
end

-- Helper function to return order to the Heap
-- @param i number The start index
function Heap:_heapify(i: number): ()
	local size = #self.Heap

	local left = 2 * i
	local right = 2 * i + 1
	local child = i

	if left <= size and self.Cmp(self.Heap[left], self.Heap[child]) then
		child = left
	end

	if right <= size and self.Cmp(self.Heap[right], self.Heap[child]) then
		child = right
	end

	if child ~= i then
		local temp = self.Heap[i]
		self.Heap[i] = self.Heap[child]
		self.Heap[child] = temp

		self:_heapify(child)
	end
end

-- Inserts an element into the Heap
-- @param element any The element to insert
-- @return number The index of the element in the Heap
function Heap:Insert(element: any): number
	table.insert(self.Heap, element)

	local elementIndex = #self.Heap
	local parentIndex = math.ceil((elementIndex - 1) / 2)

	while elementIndex ~= 1 
		and self.Cmp(self.Heap[elementIndex], self.Heap[parentIndex]) do

		local temp = self.Heap[elementIndex]
		self.Heap[elementIndex] = self.Heap[parentIndex]
		self.Heap[parentIndex] = temp

		elementIndex = parentIndex
		parentIndex = math.ceil((elementIndex - 1) / 2)
	end

	return elementIndex
end

-- Extracts the root element from the Heap
-- @return any The extracted element
function Heap:Extract(): any?
	local size = #self.Heap
	
	local rootIndex = 1
	local rootValue = self.Heap[rootIndex]

	self.Heap[rootIndex] = self.Heap[size]
	self.Heap[size] = nil

	self:_heapify(rootIndex)

	return rootValue
end

-- Returns whether the Heap is empty
-- @return boolean Whether the Heap is empty
function Heap:IsEmpty(): boolean
	return #self.Heap == 0
end

return Heap