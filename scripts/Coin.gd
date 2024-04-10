extends Area2D
@onready var level_manager = %LevelManager

func _on_body_entered(body):
	if body.name == "PlayerTest":
		queue_free()
		if level_manager != null:
			level_manager.decrement()
