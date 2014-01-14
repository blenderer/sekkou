require 'Floor'

roomtype1 = {w=5, h=5}
--roomtype2 = {w=5, h=4}
--roomtype3 = {w=6, h=3}

dungeon = Floor:new(4, 3, {roomtype1})

dungeon:build()

dungeon:print()