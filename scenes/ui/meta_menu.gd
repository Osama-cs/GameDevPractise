extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container = $%GridContainer

var meta_upgrade_card_scene = preload("res://scenes/ui/meta_upgrade_card.tscn")


func _ready():
	print("MetaMenu ready, upgrades count: ", upgrades.size())
	for upgrade in upgrades:
		print("Creating card for: ", upgrade.title)
		var meta_upgrade_card_instance = meta_upgrade_card_scene.instantiate()
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)
