(石工) Sekkou
======

石工 is japanese for "Mason", which we all know of as a professional brick/stone layer.

Sekkou is a dungeon-building class made in lua, OOP implementation by Kikito's Middleclass library. Sekkou's final product will be an x,y grid of tiles.

Example Usage like this:

```
require 'Floor'

roomtype1 = {w=4, h=11}
roomtype2 = {w=5, h=8}
roomtype3 = {w=3, h=16}

--Rooms, minimum distance of rooms, room interfaces
dungeon = Floor:new(8, 3, {roomtype1, roomtype2, roomtype3})

dungeon:build()

map = dungeon:getWalkable() --this returns an x/y grid with 1's as non-walkable and 0's as walkable

starting_spot = map[14][-6] --accessible like this

dungeon:print()
```