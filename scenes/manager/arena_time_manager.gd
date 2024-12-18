extends Node

@export var end_screen_scene: PackedScene

#Assiging a node to a varaible when it is ready to be used.
#Allows us to fetch the timer from here instead of the scene tree.
@onready var timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)


func get_time_elapsed():
	return timer.wait_time - timer.time_left


func on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
