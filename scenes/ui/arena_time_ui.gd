extends CanvasLayer

#Adds another option in the inspector to assign a node to.
@export var arena_time_manager: Node
@onready var time_label = $%Label


func _process(delta):
	if arena_time_manager == null:
		return
	var time_elpased = arena_time_manager.get_time_elapsed()
	time_label.text = format_seconds_to_string(time_elpased)


func format_seconds_to_string(seconds: float):
	var mintues = floor(seconds / 60)
	var remaining_seconds = seconds - (mintues * 60)
	return str(mintues) + ":" + ("%02d" % floor(remaining_seconds))
