extends Camera3D

signal camera_moved(position: Vector3)

# External var
@export var SCROLL_SPEED: float = 10 # Speed when use scroll mouse
@export var ZOOM_SPEED: float = 5 # Speed use when is_zoom_in or is_zoom_out is true
@export var DEFAULT_DISTANCE: float = 20 # Default distance of the Node
@export var ROTATE_SPEED: float = 10
@export var ANCHOR_NODE_PATH: NodePath
@export var MOUSE_ZOOM_SPEED: float = 10

# Event var
var _move_speed: Vector2
var _scroll_speed: float
var _touches: Dictionary
var _old_touche_dist: float
# Use to add posibility to updated zoom with external script
var is_zoom_in: bool
var is_zoom_out: bool

# Transform var
var _anchor_node: Node3D
var _rotation: Vector3
var _target_rotation: Vector3:
	set(value):
		_target_rotation = value
		_rotation = _target_rotation
		
#		if value == _target_rotation:
#			print(value)
#			return
#
#		create_tween().tween_property(
#			self,
#			"_rotation",
#			value,
#			1,
#		).set_trans(Tween.TRANS_EXPO) \
#		.set_ease(Tween.EASE_OUT)

var _distance: float
var _target_distance: float:
	set(value):
		if value == _target_distance:
			return
		value = clamp(value, min_distance, max_distance)
		create_tween().tween_property(self, "_distance", value, 1) \
			.set_trans(Tween.TRANS_EXPO) \
			.set_ease(Tween.EASE_OUT)

@export var min_distance: float
@export var max_distance: float

func _ready():
	_distance = DEFAULT_DISTANCE
	_anchor_node = self.get_node(ANCHOR_NODE_PATH)
	_rotation = _anchor_node.transform.basis \
		.get_rotation_quaternion().get_euler()

func _process(delta: float):
	if is_zoom_in:
		_scroll_speed = -1 * ZOOM_SPEED
	if is_zoom_out:
		_scroll_speed = 1 * ZOOM_SPEED
		
	# Update rotation
	_target_rotation.x += -_move_speed.y * delta * ROTATE_SPEED
	_target_rotation.y += -_move_speed.x * delta * ROTATE_SPEED
	if _target_rotation.x < -PI/2:
		_target_rotation.x = -PI/2
	if _target_rotation.x > PI/2:
		_target_rotation.x = PI/2
	_move_speed = Vector2()
	
	# Update distance
	_target_distance = _distance + _scroll_speed * delta
	_scroll_speed = 0
	
	self.set_identity()
	self.translate_object_local(Vector3(0, 0, _distance))
	_anchor_node.set_identity()
	_anchor_node.transform.basis = Basis(Quaternion.from_euler(_rotation))
	
	camera_moved.emit(global_position)

func _input(event):
	if event is InputEventMouseMotion:
		_process_mouse_rotation_event(event)
	elif event is InputEventMouseButton:
		_process_mouse_scroll_event(event)

func _process_mouse_rotation_event(e: InputEventMouseMotion):
	var rmb = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	var mmb = Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE)
	if rmb or mmb:
		_move_speed = e.relative

func _process_mouse_scroll_event(e: InputEventMouseButton):
	if e.button_index == MOUSE_BUTTON_WHEEL_UP:
		_scroll_speed = -1 * SCROLL_SPEED
	elif e.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		_scroll_speed = 1 * SCROLL_SPEED
