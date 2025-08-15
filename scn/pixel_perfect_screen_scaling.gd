extends CanvasGroup

# Deisgned to expand the game's internal small, fixed resolution for screens with much higher resolutions

@export var pixel_perfect_scale_factor: int = 1

func _ready() -> void:
	# Window size initialization
	
	ProjectSettings.set_setting("display/window/size/viewport_width", (256 * pixel_perfect_scale_factor))
	ProjectSettings.set_setting("display/window/size/viewport_height", (192 * pixel_perfect_scale_factor))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%PixelPerfectScreenScaling.scale = Vector2i(pixel_perfect_scale_factor, pixel_perfect_scale_factor)
	get_window().size = Vector2i((256 * pixel_perfect_scale_factor), (192 * pixel_perfect_scale_factor)) # Window's size should change when pixel_perfect_scale_factor changes value
	
	if Input.is_action_just_pressed("ui_up"):
		pixel_perfect_scale_factor += 1
