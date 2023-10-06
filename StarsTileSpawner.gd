extends Node3D

const RangeVector3i = preload("res://RangeVector3i.gd")



@export var tile_size: float
var loaded_tiles = {}


func _process(delta):
	var radius = 10
	var begin = Vector3(-radius, -radius, -1)
	var end = Vector3(radius, radius, -1)
	
	var star_system_prefab = load("res://star_system.tscn")
	var tile_prefab = load("res://stars_tile.tscn")
	
	for coords in RangeVector3i.new(begin, end):
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
