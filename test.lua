require 'Floor'

roomtype1 = {w=4, h=11}
roomtype2 = {w=5, h=8}
roomtype3 = {w=3, h=16}

dungeon = Floor:new(8, 3, {roomtype1, roomtype2, roomtype3})

dungeon:build()

dungeon:print()