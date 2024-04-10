extends Node

signal condition_satisfied
@export var left_to_beat = 0


func decrement():
	left_to_beat -= 1
	if (left_to_beat <= 0):
		condition_satisfied.emit()		


func _on_condition_satisfied():
	print("Collected!")
