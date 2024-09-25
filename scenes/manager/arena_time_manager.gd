extends Node

#Assiging a node to a varaible when it is ready to be used.
#Allows us to fetch the timer from here instead of the scene tree.
@onready var timer = $Timer

func get_time_elapsed():
	return timer.wait_time - timer.time_left
