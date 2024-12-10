extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0


func _ready():
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func on_timer_timeout():
	timer.start()
	# Grab the player, and if the player is null we return null.
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	#We get a random diection by taking th right diection, which is at 0 degrees.
	#Then we rotate it by a random value between 0 and 2 Pi.
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	#Next we're going to take the player postion, add it to the random diection times the spawn radius
	#and that will give the new spawn position.
	var spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	
	#We instantiate the enemy, add it to the parent of the enemy manager which is going to be main.
	#Then we asign the global postion to the spwan postion that is caluclated.
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position


func on_arena_difficulty_increased(arena_difficulty: int):
	#There is 12 5 seconds segments in a min so that is why 12 is used here.
	var time_off = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	print(time_off)
	timer.wait_time = base_spawn_time - time_off
