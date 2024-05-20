extends Node

const MENUS = {
	MAIN = "menus/main",
	OPTIONS = "menus/options",
	ENDING = "menus/ending",
	LOST = "menus/lost"
}

const levels_dict = {
	1: "first_level",
	2: "second_level",
	3: "third_level",
	4: "fourth_level"
}

var levels_count = levels_dict.size()
var current_level_id = 0


func set_scene(scene_name: String):
	get_tree().change_scene_to_file("res://scenes/levels/" + scene_name + ".tscn")

func get_level_by_id(id: int):
	return levels_dict.get(id)

func set_level_id(level_id: int):
	current_level_id = level_id
	set_scene(get_level_by_id(level_id))

func go_to_nex_level():
	if current_level_id < levels_count:
		set_level_id(current_level_id + 1)
	else:
		set_scene(MENUS.ENDING)
