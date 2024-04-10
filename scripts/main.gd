extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Запуск игры
func _on_btn_start_pressed():
	get_tree().change_scene_to_file(Global.SCENES.TEST_LEVEL)

# Опции
func _on_btn_options_pressed():
	get_tree().change_scene_to_file(Global.SCENES.OPTIONS)

# Выход из игры
func _on_btn_exit_pressed():
	get_tree().quit()
