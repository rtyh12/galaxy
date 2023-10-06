var start: Vector3i
var current: Vector3i
var end: Vector3i

func _init(start: Vector3i, stop: Vector3i):
	self.start = start
	self.current = start
	self.end = stop

func should_continue():
	return current.z <= end.z

func _iter_init(arg):
	current = start
	return should_continue()

func _iter_next(arg):
	current.x += 1
	if current.x >= end.x:
		current.x = start.x
		current.y += 1
	if current.y >= end.y:
		current.y = start.y
		current.z += 1
	return should_continue()

func _iter_get(arg):
	return current
