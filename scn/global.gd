extends Node


signal entered_cave
signal all_collectables_collected
signal scale_factor_updated

var collected_count: int = 0
var respawn_loc: Vector2


func _ready() -> void:
	entered_cave.connect(_on_entered_cave)
	all_collectables_collected.connect(_on_all_collectables_collected)
	scale_factor_updated.connect(_on_scale_factor_updated)


func _on_entered_cave() -> void:
	pass


func _on_all_collectables_collected() -> void:
	pass


func _on_scale_factor_updated() -> void:
	pass
