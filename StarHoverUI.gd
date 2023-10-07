extends Control


@export var hovered_star_indicator_radius = 20
@export var hovered_star_indicator_gap_radians = 0.3
@export var hovered_star_indicator_segment_count = 4
@export var hovered_star_indicator_spinning_offset_radians = 0
var hoveringOverStar: bool
var hovered_star_location: Vector2

# Called when the node enters the scene tree for the first time.
func _draw():
	if hoveringOverStar:
		var segments = hovered_star_indicator_segment_count
		var gap = hovered_star_indicator_gap_radians
		var offset = hovered_star_indicator_spinning_offset_radians
		for i in range(segments):
			draw_arc(
				hovered_star_location,
				hovered_star_indicator_radius,
				(i * TAU + offset) / segments + gap,
				((i + 1) * TAU + offset) / segments - gap,
				50,
				Color.ALICE_BLUE,
				2,
				true)

func _process(delta):
	hovered_star_indicator_spinning_offset_radians += 2 * delta
