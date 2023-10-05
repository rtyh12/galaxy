extends Node3D


var rng = RandomNumberGenerator.new()

func generate(
	location: Vector3i,
	star_system_scene: PackedScene,
	density: float,
	tile_size: float,
):
	for i in range(floor(density)):
		var x = rng.randf_range(0, tile_size)
		var y = rng.randf_range(0, tile_size)
		var z = rng.randf_range(0, tile_size)
		
		var star_system = star_system_scene.instantiate()
		star_system.position = Vector3(x, y, z)
		star_system.init(0)
		add_child(star_system)
