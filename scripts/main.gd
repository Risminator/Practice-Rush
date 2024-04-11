extends Node

# Запуск игры
func _on_btn_start_pressed():
	Global.set_level_id(1)

# Опции
func _on_btn_options_pressed():
	Global.set_level(Global.MENUS.OPTIONS)

# Выход из игры
func _on_btn_exit_pressed():
	get_tree().quit()
