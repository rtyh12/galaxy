extends Node3D


@export var CAMERA: Camera3D
@export var CONTROL: Control

var ray_length = 1000

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var from = CAMERA.project_ray_origin(mouse_pos)
	var to = from + CAMERA.project_ray_normal(mouse_pos) \
		* ray_length
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	CONTROL.hoveringOverStar = result.has("collider")
	if CONTROL.hoveringOverStar:
		var hovered_star_pos = result["collider"].global_position
		var indicator_pos = CAMERA.unproject_position(hovered_star_pos)
		CONTROL.hovered_star_location = indicator_pos
#		print(indicator_pos)
#		CONTROL.draw_circle(indicator_pos, 5000, Color.ALICE_BLUE)
	CONTROL.queue_redraw()

