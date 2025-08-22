# RBLX Graph

A graph implementation for Roblox's Luau programming language.

## Example Usage

```lua
-- Require Graph module
local Graph = require(--[[PATH_TO_GRAPH_MODULE]])

-- Construct a new Graph object
local myGraph = Graph.new()

-- Populate Graph
myGraph:AddEdge(1, 2, 7)
myGraph:AddEdge(1, 3, 9)
myGraph:AddEdge(1, 6, 14)
myGraph:AddEdge(2, 3, 10)
myGraph:AddEdge(2, 4, 15)
myGraph:AddEdge(3, 4, 11)
myGraph:AddEdge(3, 6, 2)
myGraph:AddEdge(4, 5, 6)
myGraph:AddEdge(5, 6, 9)

-- Vertices 7 and 8 are disconnected from the rest of the Graph
myGraph:AddEdge(7, 8, 9)

-- Print shortest path from vertex 1 to vertex 5
print(myGraph:PathTo(1, 5)) -- Out: {1, 3, 6, 5}, 20
-- No path from vertex 1 to vertex 8 exists
print(myGraph:PathTo(1, 8)) -- Out: {}, inf
```

**Note:** Graph:PathTo requires the `Heap` module to run Dijkstra's algorithm. Place it in the same directory as the Graph module.
