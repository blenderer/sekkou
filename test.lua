require 'Floor'

roomtype1 = {w=5, h=6}
roomtype2 = {w=2, h=1}

dungeon = Floor:new(2, {roomtype1, roomtype2})

dungeon:build()

dungeon:print()