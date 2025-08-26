extends CanvasGroup

var scale_factor: int = 1:
	set(value):
		scale_factor = value
		_set_pixel_perfect_size()

# Deisgned to expand the game's internal small, fixed resolution for
# screens with much higher resolutions

func _ready() -> void:
	_set_pixel_perfect_size()
	
	#Engine.time_scale = 0.5


func _set_pixel_perfect_size() -> void:
	%PixelPerfectScreenScaling.scale = Vector2i(scale_factor, scale_factor)
	get_window().size = Vector2i(
	(256 * scale_factor), (192 * scale_factor)
	)

# In-game window rescaling
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("inc_screen_scale"):
		if scale_factor <= 5:
			scale_factor += 1

	if Input.is_action_just_pressed("dec_screen_scale"):
		if scale_factor >= 2:
			scale_factor -= 1
