local Heap = require(script.Parent.Heap)

local Graph = {}
Graph.__index = Graph

--[[
	Simple undirected graph implementation using an adjacency list
]]

-- Constructs an empty Graph object.
function Graph.new()
	local self = {
		Graph = {},
	}

	setmetatable(self, Graph)

	return self
end

-- Adds an edge between two vertices with a given weight.
-- @param u any The first vertex.
-- @param v any The second vertex.
-- @param w number The weight of the edge connecting the two vertices.
function Graph:AddEdge(u: any, v: any, w: number)
	if not self.Graph[u] then self.Graph[u] = {} end
	if not self.Graph[v] then self.Graph[v] = {} end

	self.Graph[u][v] = w
	self.Graph[v][u] = w
end

-- Computes a shortest path between source and target vertex using Dijkstra's algorithm.
-- @param source any The start vertex.
-- @param target any The end vertex.
-- @return ({any}, number) A tuple containing a list of a shortest path, and the path's
-- length.
function Graph:PathTo(source: any, target: any): ({any}, number)
	local dist = {}
	local prev = {}

	local priorityQueue = Heap.new(function(p, c) return p[1] < c[1] end)

	for v, _ in self.Graph do
		prev[v] = nil
		dist[v] = math.huge
	end

	dist[source] = 0
	priorityQueue:Insert({0, source})

	while not priorityQueue:IsEmpty() do
		local u = priorityQueue:Extract()[2]
		
		if u == target then break end

		for v, w in self.Graph[u] do
			local alt = dist[u] + w

			if alt < dist[v] then
				prev[v] = u
				dist[v] = alt
				priorityQueue:Insert({alt, v})
			end
		end
	end
	
	local currentNode = target
	local path = {}
	
	if prev[currentNode] then
		table.insert(path, currentNode)

		-- Backtrack predecessors list to find path
		while prev[currentNode] ~= nil do
			table.insert(path, prev[currentNode])
			currentNode = prev[currentNode]
			if currentNode == source then break end
		end

		-- Reverse backtracked path
		local left = 1
		local right = #path

		while left < right do
			local temp = path[left]
			path[left] = path[right]
			path[right] = temp

			left += 1
			right -= 1
		end
	end
	
	return path, dist[target]
end

-- Print the Graph as represented by an adjacency list
function Graph:Print()
	print(self.Graph)
end

return Graph