require 'Floor'

roomtype1 = {w=8, h=5}
roomtype2 = {w=7, h=4}
roomtype3 = {w=4, h=4}

dungeon = Floor:new(3, {roomtype1})

dungeon:build()

dungeon:print()