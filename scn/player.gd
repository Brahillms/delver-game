class_name Player extends Node2D


signal has_died


const JUMP_VELOCITY: float = -240.0
const SPEED: float = 80.0


func _hurt() -> void:
	
	
	has_died.emit()
	
	
	visible = false
	
	
	has_died.emit()
	var chance: int = randi() % 999
	
	
	if chance == 438:
		$GameOverSFX.play()
	
	
	$HurtSFX.play()
	await $HurtSFX.finished
	
	
	visible = true


func _ready() -> void:
	Global.entered_cave.connect(_on_entered_cave)
	Global.roll_credits.connect(_on_roll_credits)


func _on_entered_cave() -> void:
	position += Vector2((256 * 2) - (8 * 10), -192)


func _on_hurtbox_manager_area_entered(_area: Area2D) -> void:
	_hurt()


func _on_roll_credits() -> void:
	queue_free()
