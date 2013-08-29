require 'Floor'

roomtype1 = {w=9, h=9}
--roomtype2 = {w=5, h=4}
--roomtype3 = {w=6, h=3}

dungeon = Floor:new(2, 3, {roomtype1})

dungeon:build()

dungeon:print()