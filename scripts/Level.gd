extends Node

signal condition_satisfied
@export var left_to_beat = 0

var is_winnable = true

func decrement():
	left_to_beat -= 1
	if (left_to_beat <= 0):
		condition_satisfied.emit()		

func _on_exit_body_entered(body):
	if is_winnable:
		Global.go_to_next_level()


func _on_timer_timeout():
	is_winnable = false
	Global.set_scene(Global.MENUS.LOST)
