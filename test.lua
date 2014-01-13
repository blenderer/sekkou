require 'Floor'

roomtype1 = {w=7, h=4}
roomtype2 = {w=5, h=4}
roomtype3 = {w=6, h=3}

dungeon = Floor:new(4, 3, {roomtype1, roomtype2, roomtype3})

dungeon:build()

dungeon:print()