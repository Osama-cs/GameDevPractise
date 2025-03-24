extends Node


@export var health_component: Node
@export var sprite: Sprite2D
@export var hit_flash_material: ShaderMaterial

var hit_flash_tween: Tween


func _ready():
	health_component.health_changed.connect(on_health_changed)
	sprite.material = hit_flash_material


func on_health_changed():
	#if we have a hit flash tween that is alreday running we want to kill it, this invalidates the tween
	if hit_flash_tween != null && hit_flash_tween.is_valid():
		hit_flash_tween.kill()
	
	# we set the shader value to one before we make the tween then we tween it down to 0 over 0.2 seconds.
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, 0.3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
