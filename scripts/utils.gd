extends Node2D

const SAVE_PATH = "res://save_json.json"
var seconds : float

func level_sys():
	pass

#new game settings, spawn points, etc
func new_game() -> void:
	Global.is_paused = false
	#Global.active_party = ["Lucia","Renzo" ]
#get initial lv from char resource
	Global.active_party = []
	add_char("Renzo")
	add_char("Lucia")
	Global.game_time = 0
	Global.gold = 500
	Global.movcounter = 0.0
	Global.player_xy = Vector2(64 , 64)
	Global.raycast_direction = Vector2(0 , 32)
	Global.player_map_location = "test_area"
	Global.chest_flags.fill(0)
	#initial inventory settings
	var inv_it := load("res://data/items/inv_items.tres")
	var inv_ms := load("res://data/items/inv_misc.tres")
	var inv_we := load("res://data/items/inv_weap.tres")
	var inv_ra := load("res://data/items/inv_rare.tres")
	inv_it.slot_datas.clear()
	inv_ms.slot_datas.clear()
	inv_we.slot_datas.clear()
	inv_ra.slot_datas.clear()
	#load the start inventory and add to the game inv with the add_item() func
	#Edit the inv_start.tres resource to add or change the initial items
	var start_inv = load("res://data/items/inv_start.tres")
	var inv_dict = start_inv.slot_datas
	for key in inv_dict:
		add_item(key, inv_dict.get(key))

func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var inv_it := load("res://data/items/inv_items.tres")
	var inv_ms := load("res://data/items/inv_misc.tres")
	var inv_we := load("res://data/items/inv_weap.tres")
	var inv_ra := load("res://data/items/inv_rare.tres")
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict = {
		game = {
			gold = var_to_str(Global.gold),
			time = var_to_str(Global.game_time),
			spawnx = var_to_str(Global.player_xy.x),
			spawny = var_to_str(Global.player_xy.y),
			activemap = var_to_str(Global.player_map_location),
			party = var_to_str(Global.active_party)
		},
		chars = {
			char_lv = var_to_str(Global.char_levels),
			
		},
		flags = {
			chest = var_to_str(Global.chest_flags),
		},
		items = {
			items = var_to_str(inv_it.slot_datas),
			misc = var_to_str(inv_ms.slot_datas),
			weapons = var_to_str(inv_we.slot_datas),
			rare = var_to_str(inv_ra.slot_datas)
		}
	}

	file.store_line(JSON.stringify(save_dict))
	


func load_game():
	var inv_it := load("res://data/items/inv_items.tres")
	var inv_ms := load("res://data/items/inv_misc.tres")
	var inv_we := load("res://data/items/inv_weap.tres")
	var inv_ra := load("res://data/items/inv_rare.tres")
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	
	# JSON doesn't support many of Godot's types such as Vector2.
	# str_to_var can be used to convert a String to the corresponding Variant.
#game global vars
	Global.gold = str_to_var(save_dict.game.gold)
	Global.game_time = str_to_var(save_dict.game.time)
	Global.player_xy.x = str_to_var(save_dict.game.spawnx)
	Global.player_xy.y = str_to_var(save_dict.game.spawny)
	Global.player_map_location = str_to_var(save_dict.game.activemap)
	Global.active_party = str_to_var(save_dict.game.party)
# chars stats
	Global.char_levels = str_to_var(save_dict.chars.char_lv)
	
#event flags
	Global.chest_flags = str_to_var(save_dict.flags.chest)
#inventory
	inv_it.slot_datas = str_to_var(save_dict.items.items)
	inv_ms.slot_datas = str_to_var(save_dict.items.misc)
	inv_we.slot_datas = str_to_var(save_dict.items.weapons)
	inv_ra.slot_datas = str_to_var(save_dict.items.rare)



func load_battle():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")
	
func add_item(item, amount) -> void: #item_data is a dictionary
	#check type of item
	var inv_data := preload("res://data/items/inv_items.tres")
	var item_type = item.type
	
	match item_type:
		"item":
			inv_data = preload("res://data/items/inv_items.tres")
		"weap":
			inv_data = preload("res://data/items/inv_weap.tres")
		"armor":
			inv_data = preload("res://data/items/inv_weap.tres")
		"misc":
			inv_data = preload("res://data/items/inv_misc.tres")
		"key":
			inv_data = preload("res://data/items/inv_rare.tres")
	#create a new temp dictionary to store the new item and then add to te inventory
	var new_items : Dictionary = {}
	new_items[item] = amount
	print(new_items)
	for key in new_items.keys():
		if key in inv_data.slot_datas.keys():
			inv_data.slot_datas[key] += new_items[key]
		else:
			inv_data.slot_datas[key] = new_items[key]
			

#game time function
func _physics_process(delta):
	seconds = seconds + delta
	if seconds >= 60:
		seconds = 0
		Global.game_time += 1

func add_char(char:String):
	var res := load("res://data/chars/"+char+".tres")
	var char_name = res.name
	Global.active_party.append(char_name)
	if char_name in Global.char_levels:
		print("c'è già")
	else:
		Global.char_levels[char_name] = res.initial_level
	
