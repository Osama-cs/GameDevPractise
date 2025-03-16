extends PanelContainer

signal selected

@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel

var disabled = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)

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
	$TransitionAnimationPlayer.play("in")


func play_discard():
	$TransitionAnimationPlayer.play("discarded")


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description

func select_card():
	disabled = true
	$TransitionAnimationPlayer.play("selected")
	
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_discard()
	
	await $TransitionAnimationPlayer.animation_finished
	selected.emit()

func on_gui_input(event: InputEvent):
	if disabled:
		return
	
	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered():
	if disabled:
		return
	
	$HoverAnimationPlayer.play("hover")
