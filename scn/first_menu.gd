extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.screen_scale_intitialized.connect(_on_screen_scale_initialized)
	$KeyO.play("idle")
	$KeyP.play("idle")
	$OKButton.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("inc_screen_scale"):
		$KeyO.play("pressed")
	else:
		$KeyO.play("idle")

	if Input.is_action_pressed("dec_screen_scale"):
		$KeyP.play("pressed")
	else:
		$KeyP.play("idle")

	if Input.is_action_pressed("ui_accept"):
		$OKButton.play("pressed")
	if Input.is_action_just_released("ui_accept"):
		Global.screen_scale_intitialized.emit()


func _on_screen_scale_initialized() -> void:
	queue_free()
