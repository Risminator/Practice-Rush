extends Node

@onready var btn_exit: Button = $Buttons/BtnExit

func _ready():
	if OS.has_feature("web"):
		btn_exit.clip_text = true
		btn_exit.disabled = true
		btn_exit.visible = false

# Запуск игры
func _on_btn_start_pressed():
	Global.set_level_id(1)

# Опции
func _on_btn_options_pressed():
	Global.set_scene(Global.MENUS.OPTIONS)

# Выход из игры
func _on_btn_exit_pressed():
	get_tree().quit()
