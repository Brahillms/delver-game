class_name Player extends Node2D

var health: int = 100

func take_damage() -> void:
	health -= 10
	print(health)
