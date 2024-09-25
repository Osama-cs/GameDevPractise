extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	# Grab the player, and if the player is null we return null.
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	#We get a random diection by taking th right diection, which is at 0 degrees.
	#Then we rotate it by a random valye between 0 and 2 Pi.
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	#Next we're going to take the player postion, add it to the random diection times the spawn radius
	#and that will give the new spawn position.
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	#We instantiate the enemy, add it to the parent of the enemy manager which is going to be main.
	#Then we asign the global postion to the spwan postion that is caluclated.
	var enemy = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
