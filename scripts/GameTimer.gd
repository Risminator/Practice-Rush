extends Control

@export var wait_time: float = 120

@onready var timer = $Timer
@onready var label = $TimerLabel

signal game_timeout()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = wait_time
	timer.start()


func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(_delta):
	label.text = "%02d:%02d" % time_left_to_live()


func _on_timer_timeout():
	timer.stop()
	game_timeout.emit()
	
