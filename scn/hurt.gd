extends Area2D


func _hurt() -> void:
	
	
	var chance: int = randi() % 999
	
	
	if chance == 438:
		$GameOverSFX.play()
	
	
	$HurtSFX.play()
	await $HurtSFX.finished


func _on_area_entered(_area: Area2D) -> void:
	_hurt()
