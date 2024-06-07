extends Node2D

const SAVE_PATH = "res://save_json.json"
var seconds : float

func level_sys():
	pass

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var inv_data := load("res://data/items/testinv.tres")
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict = {
		player = {
			gold = var_to_str(Global.gold),
			time = var_to_str(Global.game_time),
			spawnx = var_to_str(Global.player_xy.x),
			spawny = var_to_str(Global.player_xy.y),
			activemap = var_to_str(Global.player_map_location),
			party = var_to_str(Global.active_party)
		},
		flags = {
			chest = var_to_str(Global.chest_flags)
		},
		items = {
			inventory = var_to_str(inv_data.slot_datas)
		}
	}

	file.store_line(JSON.stringify(save_dict))
	


func load_game():
	var inv_data := load("res://data/items/testinv.tres")
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	
	# JSON doesn't support many of Godot's types such as Vector2.
	# str_to_var can be used to convert a String to the corresponding Variant.
	Global.gold = str_to_var(save_dict.player.gold)
	Global.game_time = str_to_var(save_dict.player.time)
	Global.player_xy.x = str_to_var(save_dict.player.spawnx)
	Global.player_xy.y = str_to_var(save_dict.player.spawny)
	Global.player_map_location = str_to_var(save_dict.player.activemap)
	Global.chest_flags = str_to_var(save_dict.flags.chest)
	Global.active_party = str_to_var(save_dict.player.party)
	inv_data.slot_datas = str_to_var(save_dict.items.inventory)

	# Ensure the node structure is the same when loading.
	#var game := get_node(game_node)

func load_battle():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")
	
func add_item(item_data) -> void:
	var inv_data = preload("res://data/items/testinv.tres")
	for key in item_data.keys():
		if key in inv_data.slot_datas.keys():
			inv_data.slot_datas[key] += item_data[key]
		else:
			print("oggetti nuovi")
			inv_data.slot_datas[key] = item_data[key]
			print("nuovo inventario: ", inv_data.slot_datas)

func open_textbox() -> void:
	pass

func _physics_process(delta):
	seconds = seconds + delta
	if seconds >= 60:
		seconds = 0
		Global.game_time += 1
