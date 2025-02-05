extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0
var enemy_table = WeightedTable.new()


func _ready():
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func get_spawn_position():
	# Grab the player, and if the player is null we return null.
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	# assign intial spawn postion for the enemy
	var spawn_position = Vector2.ZERO
	#We get a random diection by taking th right diection, which is at 0 degrees.
	#Then we rotate it by a random value between 0 and 2 Pi.
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	for i in 4:
		#Next we're going to take the player postion, add it to the random diection times the spawn radius
		#and that will give the new spawn position.
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		# we create a ray cast query using the player postion and the spawn postion of the enemy as the start 
		# and end point of the ray. We also check against the terrian layer for our collsion, which is 1.
		var query_paramaters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		# we make an interesct ray call here to make sure the enemy interscts with the right terrian,
		# then it gets stored in a result dictionary.
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
		# if the dictionary is empty it calls the orginal spawn postion that was called at the start
		if result.is_empty():
			break
		# if it's not empty we want to change the random direction by 90 degress allowing the emeny to spawn
		# within the walls of our game, and allows the loop to start again.
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	# we check up to 4 rays until we find the one that isn't colliding with any terrain and the last set 
	# spawn position is what will be returned.
	return spawn_position


func on_timer_timeout():
	timer.start()
	# Grab the player, and if the player is null we return null.
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemy_scene = enemy_table.pick_item()
	#We instantiate the enemy, add it to the parent of the enemy manager which is going to be main.
	#Then we asign the global postion to the spwan postion that is caluclated.
	var enemy = enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()


func on_arena_difficulty_increased(arena_difficulty: int):
	#There is 12 5 seconds segments in a min so that is why 12 is used here.
	var time_off = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	print(time_off)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
