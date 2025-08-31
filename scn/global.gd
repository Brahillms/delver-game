extends Node


signal entered_cave
signal all_collectables_collected
signal scale_factor_updated
signal screen_scale_intitialized
signal roll_credits


var collected_count: int = 0
var respawn_loc: Vector2


func _ready() -> void:
	entered_cave.connect(_on_entered_cave)
	all_collectables_collected.connect(_on_all_collectables_collected)
	scale_factor_updated.connect(_on_scale_factor_updated)
	screen_scale_intitialized.connect(_on_screen_scale_initialized)
	roll_credits.connect(_on_roll_credits)


func _on_entered_cave() -> void:
	pass


func _on_all_collectables_collected() -> void:
	pass


func _on_scale_factor_updated() -> void:
	pass


func _on_screen_scale_initialized() -> void:
	pass


func _on_roll_credits() -> void:
	pass
