class_name Player extends Node2D


const JUMP_VELOCITY: float = -270.0
const SPEED: float = 80.0


func _ready() -> void:
	Global.entered_cave.connect(_on_entered_cave)


func _on_entered_cave() -> void:
	position += Vector2((256 * 2) - (8 * 10), -192)
