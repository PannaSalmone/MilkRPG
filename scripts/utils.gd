extends Node2D

const SAVE_PATH = "res://save_json.json"
var seconds : float
var multi

func level_sys():
	pass

#new game settings, spawn points, etc
func new_game() -> void:
	Global.is_paused = false
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
	var inv_eq := load("res://data/items/inv_equipped.tres")
	inv_it.slots = []
	inv_ms.slots = []
	inv_we.slots = []
	inv_ra.slots = []
	inv_eq.slots = []
	#load the start inventory and add to the game inv with the add_item() func
	#Edit the inv_start.tres resource to add or change the initial items
	var start_inv = load("res://data/initial_data/init_inventory.tres")
	var inv_dict = start_inv.slot_datas
	for key in inv_dict:
		add_item(key, inv_dict.get(key))
	
	# initialize characters variables
	Char.active_party = []
	Char.add_char_to_party("Renzo")
	Char.add_char_to_party("Lucia")
	Char.init_char("Renzo")
	Char.init_char("Lucia")
	
	
func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var inv_it := load("res://data/items/inv_items.tres")
	var inv_ms := load("res://data/items/inv_misc.tres")
	var inv_we := load("res://data/items/inv_weap.tres")
	var inv_ra := load("res://data/items/inv_rare.tres")
	var inv_eq := load("res://data/items/inv_equipped.tres")
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict = {
		game = {
			gold = var_to_str(Global.gold),
			time = var_to_str(Global.game_time),
			spawnx = var_to_str(Global.player_xy.x),
			spawny = var_to_str(Global.player_xy.y),
			activemap = var_to_str(Global.player_map_location),
			party = var_to_str(Char.active_party)
		},
		chars = {
			renzo_eq = var_to_str(Char.renzo.equipment),
			lucia_eq = var_to_str(Char.lucia.equipment)
			
		},
		flags = {
			chest = var_to_str(Global.chest_flags),
		},
		items = {
			items = var_to_str(inv_it.slots),
			misc = var_to_str(inv_ms.slots),
			weapons = var_to_str(inv_we.slots),
			rare = var_to_str(inv_ra.slots),
			equipped = var_to_str(inv_eq.slots)
		}
	}

	file.store_line(JSON.stringify(save_dict))

func load_game():
	var inv_it := load("res://data/items/inv_items.tres")
	var inv_ms := load("res://data/items/inv_misc.tres")
	var inv_we := load("res://data/items/inv_weap.tres")
	var inv_ra := load("res://data/items/inv_rare.tres")
	var inv_eq := load("res://data/items/inv_equipped.tres")
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
	Char.active_party = str_to_var(save_dict.game.party)
# chars stats
	Char.renzo.equipment = str_to_var(save_dict.chars.renzo_eq)
	Char.lucia.equipment = str_to_var(save_dict.chars.lucia_eq)
	
#event flags
	Global.chest_flags = str_to_var(save_dict.flags.chest)
#inventory
	inv_it.slots = str_to_var(save_dict.items.items)
	inv_ms.slots = str_to_var(save_dict.items.misc)
	inv_we.slots = str_to_var(save_dict.items.weapons)
	inv_ra.slots = str_to_var(save_dict.items.rare)
	inv_eq.slots = str_to_var(save_dict.items.equipped)
	


func load_battle():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")
	
func add_item(item, amount) -> void:
	# Check type of item
	var inv_data : Resource
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
	
	var item_list : Array = inv_data.slots
	var item_found = false
	
# Check if the item already exists in the inventory
	for it in item_list:
		if it.item.name == item.name:
			it.qnt += amount
			item_found = true
			break
	
	# If the item does not exist, add a new slot
	if not item_found:
		var slot = ItemSlot.new()
		slot.item = item
		slot.qnt = amount
		inv_data.slots.insert(0, slot)
		

func remove_item(item, amount) -> void:
	# Check type of item
	var inv_data : Resource
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
	
	var item_list : Array = inv_data.slots
	var item_found = false
	# Check if the item already exists in the inventory
	for it in item_list:
		if it.item.name == item.name:
			if it.qnt >= amount:
				it.qnt -= amount
			if it.qnt <= 0:
				item_list.erase(it)
			item_found = true
			break
	if not item_found:
		print("WTF, u have removed an item that u don't have?")

func add_equipped_item(item, amount) -> void:
	var inv_data = preload("res://data/items/inv_equipped.tres")
	var slot = ItemSlot.new()
	slot.item = item
	slot.qnt += amount
	slot.is_locked = true
	inv_data.slots.append(slot)

func remove_item_equipped(item) -> void:
	var inv_data = preload("res://data/items/inv_equipped.tres")
	var array = inv_data.slots
	var item_to_remove = null
	for eq_item in array:
		if eq_item.item.name == item.name:
			item_to_remove = eq_item
			break
	array.erase(item_to_remove)
	inv_data.slots = array
	add_item(item, 1)
#game time function
func _physics_process(delta):
	seconds = seconds + delta
	if seconds >= 60:
		seconds = 0
		Global.game_time += 1
