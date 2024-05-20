extends Node

signal condition_satisfied
@onready var left_to_beat = get_tree().get_nodes_in_group("PICKABLE").size()

var is_winnable = true
var is_condition_satisfied = false


func decrement():
	left_to_beat -= 1
	if (left_to_beat <= 0):
		condition_satisfied.emit()		

func _on_exit_body_entered(_body):
	if is_winnable and is_condition_satisfied:
		call_deferred("level_won")

func _on_condition_satisfied():
	is_condition_satisfied = true

func _on_game_timer_game_timeout():
	is_winnable = false
	call_deferred("lose")

func lose():
	Global.set_scene(Global.MENUS.LOST)

func level_won():
	Global.go_to_next_level()
