extends Area2D

func _enter_tree():
	add_to_group("PICKABLE")

func _on_body_entered(body):
	if body.name == "PlayerTest":
		Events.pickable_collected.emit()
		queue_free()
