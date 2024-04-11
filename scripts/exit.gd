extends Area2D

func _on_level_manager_condition_satisfied():
	$GPUParticles2D.amount = 16
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.hex(0xffffffff), 1)
