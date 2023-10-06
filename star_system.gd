extends Node3D


func _ready():
	var camera_emitter = $/root/galaxy/ship/CameraAnchor/OrbitCamera
	camera_emitter.connect("camera_moved", _on_camera_moved)

func _on_camera_moved(new_position: Vector3):
	pass
	#print(new_position)

func init(seed: int):
	pass
