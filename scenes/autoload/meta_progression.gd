extends Node


# Example of how you can use nseted dictionaries to store specific data.
#var meta_upgardes: Dictionary = {
	#"win_count": 0, 
	#"loss:count": 0,
	#"meta_upgarde_currency": 0, 
	#"meta_upgrade": {
			#"experience_gain": {
			#"quantity": 1,
		#}
	#}
#}


var save_data: Dictionary = {
	"meta_upgarde_currency": 0, 
	"meta_upgrades": {}
}

func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_collected)
	add_meta_upgarde(load("res://resources/meta_upgrades/experience_gain.tres"))


func add_meta_upgarde(upgrade: MetaUpgrade):
	if !save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	print(save_data)


func on_experience_collected(number: float):
	save_data["meta_upgrade_currency"] += number

