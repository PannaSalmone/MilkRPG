extends Node2D

const SAVE_PATH = "res://save_json.json"

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict = {
		player = {
			gold = var_to_str(Global.gold),
			spawnx = var_to_str(Global.player_xy.x),
			spawny = var_to_str(Global.player_xy.y),
			activemap = var_to_str(Global.player_map_location)
		},
		flags = {
			chest = var_to_str(Global.chest_flags)
		},
		items = {
			inventory = var_to_str(Global.items)
		}
	}

	file.store_line(JSON.stringify(save_dict))
	


func load_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	
	# JSON doesn't support many of Godot's types such as Vector2.
	# str_to_var can be used to convert a String to the corresponding Variant.
	Global.gold = str_to_var(save_dict.player.gold)
	Global.player_xy.x = str_to_var(save_dict.player.spawnx)
	Global.player_xy.y = str_to_var(save_dict.player.spawny)
	Global.player_map_location = str_to_var(save_dict.player.activemap)
	Global.chest_flags = str_to_var(save_dict.flags.chest)
	Global.items = str_to_var(save_dict.items.inventory)

	# Ensure the node structure is the same when loading.
	#var game := get_node(game_node)
	
