extends Node3D


@export var tile_size: float
var loaded_tiles = {}

func make_range(begin: Vector3i, end: Vector3i):
	var output = []
	for x in range(begin.x, end.x + 1):
		for y in range(begin.y, end.y + 1):
			for z in range(begin.z, end.z + 1):
				output.append(Vector3(x, y, z))
	
	return output

func _process(delta):
	var radius = 20
	var begin = Vector3(-radius, -radius, 0)
	var end = Vector3(radius, radius, 0)
	
	var star_system_prefab = load("res://star_system.tscn")
	var tile_prefab = load("res://stars_tile.tscn")
	
	for coords in make_range(begin, end):
		if loaded_tiles.has(coords):
			continue
		
		var tile = tile_prefab.instantiate()
		tile.position = coords * tile_size
		tile.generate(
			coords,
			star_system_prefab,
			10,
			tile_size)
		add_child(tile)
		loaded_tiles[coords] = tile
