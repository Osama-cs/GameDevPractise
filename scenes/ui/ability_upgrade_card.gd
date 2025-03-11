extends PanelContainer

signal selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel

func _ready():
	gui_input.connect(on_gui_input)

func play_in(delay: float = 0):
	# use modulate to hide a UI compoent but keeping it in the layout
	modulate = Color.TRANSPARENT
	# we create a timer (this is a scene tree timer, good way to make one off timers)
	# we pass in a delay to tell the timer to wait a certin amount of time, then timeout
	# referenecres the timeout signal.
	# await meanss that we stop the excution of the play_in function, until the timeout
	# signal has been emited.
	await get_tree().create_timer(delay).timeout
	# white here is the upgrade card defualt. this is now in the animation player instead
	#modulate = Color.WHITE
	$AnimationPlayer.play("in")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
