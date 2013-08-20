require 'Floor'

dungeon = Floor:new(2, {{w=5, h=6}, {w=2, h=1}})

dungeon:build()

dungeon:print()