extends Node3D


@export var collision_mesh_base_scale: float

@export var COLLISION_BODY: Node3D


func _ready():
	var camera_emitter = $/root/galaxy/ship/CameraAnchor/OrbitCamera
	camera_emitter.connect("camera_moved", _on_camera_moved)

func _on_camera_moved(new_position: Vector3):
	var dist_to_camera = global_position.distance_to(new_position)
	COLLISION_BODY.scale = Vector3(1, 1, 1) *\
		collision_mesh_base_scale * dist_to_camera

func init(seed: int):
	pass
