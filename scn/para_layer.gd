extends ParallaxLayer


@onready var pixel_perfect_screen_scaling: CanvasGroup = get_node("../../..")


var was_motion_scale: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	was_motion_scale = motion_scale
	Global.scale_factor_updated.connect(_on_scale_factor_updated)


func _on_scale_factor_updated() -> void:
	motion_scale = Vector2(was_motion_scale.x / pixel_perfect_screen_scaling.scale_factor, 1.0)
