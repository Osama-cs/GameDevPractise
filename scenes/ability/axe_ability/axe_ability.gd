extends Node2D

#define max radius and how far the axe can be from the player
const MAX_RADIUS = 100

@onready var hitbox_component: HitboxComponent = $HitboxComponent

var base_rotation = Vector2.RIGHT

func _ready():
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var tween = create_tween()
	#we are telling the tween we wnat it to go between a value of 0 to 2 over 3 secs
	#and while the tween is happeing call the "tween_method"
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	#this free the axe from the tween for us, making the axe disapper when the animation  is done
	tween.tween_callback(queue_free)

#when we define this metohd we are taking in how many rotations that have happened
func tween_method(rotations: float):
	var percent = rotations / 2
	#we get the percentage value to findout what the radius should be. For this
	#instance it is between 0 and 100
	var current_radius = percent * MAX_RADIUS
	#take the numebr rotaions and times it by TAU, and use that as a rotation and apply that
	#to the right vector and in random direction.
	var current_direction = base_rotation.rotated(rotations * TAU)
	#This code below is figuring out how to position the axe
	var player = get_tree().get_first_node_in_group("player")
	#if the player doesn't exist, the axe won't move
	if player == null:
		return
	#if the player does exist, then we set the axe to the players global position,
	#then we rotate the axe around the players position. Next we offeset it by the
	#current diection and current radius
	global_position = player.global_position + (current_direction * current_radius)
