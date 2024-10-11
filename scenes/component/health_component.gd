extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health

func _ready():
	current_health = max_health

func damage(damage_amount: float):
	#unoptimal code as it will allow health to go into the minues which we son't want.
	#current_health -= damage_amount
	current_health = max(current_health - damage_amount, 0)
	#This will stop an error from appearing that will not affect the code.
	Callable(check_death).call_deferred()



func check_death():
	if current_health == 0:
		died.emit()
		#an owner is a node that the main node of the child node. So right now in the healthComponent
		#nothing is the owner but in the player node, the Player is the owner of evreything in that
		#node.
		owner.queue_free()
