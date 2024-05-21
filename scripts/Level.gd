extends Node

@onready var left_to_beat = get_tree().get_nodes_in_group("PICKABLE").size()
@onready var black_screen: AnimationPlayer = $CanvasLayer/ColorRect/AnimationPlayer

var is_winnable = true

func _ready():
	Events.player_death.connect(_on_player_death)
	Events.pickable_collected.connect(_on_pickable_collected)

func _on_pickable_collected():
	left_to_beat -= 1
	if left_to_beat <= 0 and is_winnable:
		Events.condition_satisfied.emit()


func _on_game_timer_game_timeout():
	is_winnable = false
	lose.call_deferred()

func _on_player_death():
	lose()

func lose():
	black_screen.play("fade_in")
	get_tree().reload_current_scene()

func level_won():
	Global.go_to_next_level()
