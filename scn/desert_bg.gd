extends ParallaxBackground


@onready var pixel_perfect_screen_scaling = get_node("../..")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	transform = Transform2D(Vector2(pixel_perfect_screen_scaling.scale_factor, 0.0), Vector2(0.0, pixel_perfect_screen_scaling.scale_factor), Vector2.ZERO)
