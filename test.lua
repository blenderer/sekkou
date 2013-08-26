require 'Floor'

roomtype1 = {w=8, h=5}
roomtype2 = {w=7, h=4}
roomtype3 = {w=4, h=4}

dungeon = Floor:new(5, 3, {roomtype1, roomtype2, roomtype3})

dungeon:build()

dungeon:print()