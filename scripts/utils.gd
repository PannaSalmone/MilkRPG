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
	Global.player_xy = Vector2(128 , 128)
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
	var renzo := load("res://data/chars/Renzo.tres")
	var lucia := load("res://data/chars/Lucia.tres")
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
			#Renzo
			renzo_name = var_to_str(renzo.name),
			renzo_title = var_to_str(renzo.title_class),
			renzo_level = var_to_str(renzo.level),
			renzo_exp = var_to_str(renzo.exp),
			renzo_status = var_to_str(renzo.status),
			renzo_head = var_to_str(renzo.head),
			renzo_body = var_to_str(renzo.body),
			renzo_arms = var_to_str(renzo.arms),
			renzo_legs = var_to_str(renzo.legs),
			renzo_hand_dx = var_to_str(renzo.hand_dx),
			renzo_hand_sx = var_to_str(renzo.hand_sx),
			renzo_acc1 = var_to_str(renzo.acc1),
			renzo_acc2 = var_to_str(renzo.acc2),
			renzo_hp = var_to_str(renzo.HP),
			renzo_mp = var_to_str(renzo.MP),
			renzo_str = var_to_str(renzo.STRENGHT),
			renzo_agi = var_to_str(renzo.AGILITY),
			renzo_vig = var_to_str(renzo.VIGOR),
			renzo_int = var_to_str(renzo.INTELLECT),
			renzo_spi = var_to_str(renzo.SPIRIT),
			renzo_cur_hp = var_to_str(renzo.cur_HP),
			renzo_cur_mp = var_to_str(renzo.cur_MP),
			#Lucia
			lucia_name = var_to_str(lucia.name),
			lucia_title = var_to_str(lucia.title_class),
			lucia_level = var_to_str(lucia.level),
			lucia_exp = var_to_str(lucia.exp),
			lucia_status = var_to_str(lucia.status),
			lucia_head = var_to_str(lucia.head),
			lucia_body = var_to_str(lucia.body),
			lucia_arms = var_to_str(lucia.arms),
			lucia_legs = var_to_str(lucia.legs),
			lucia_hand_dx = var_to_str(lucia.hand_dx),
			lucia_hand_sx = var_to_str(lucia.hand_sx),
			lucia_acc1 = var_to_str(lucia.acc1),
			lucia_acc2 = var_to_str(lucia.acc2),
			lucia_hp = var_to_str(lucia.HP),
			lucia_mp = var_to_str(lucia.MP),
			lucia_str = var_to_str(lucia.STRENGHT),
			lucia_agi = var_to_str(lucia.AGILITY),
			lucia_vig = var_to_str(lucia.VIGOR),
			lucia_int = var_to_str(lucia.INTELLECT),
			lucia_spi = var_to_str(lucia.SPIRIT),
			lucia_cur_hp = var_to_str(lucia.cur_HP),
			lucia_cur_mp = var_to_str(lucia.cur_MP)
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
	var renzo := load("res://data/chars/Renzo.tres")
	var lucia := load("res://data/chars/Lucia.tres")
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
	#renzo
	Char.renzo.name = str_to_var(save_dict.chars.renzo_name)
	Char.renzo.title_class = str_to_var(save_dict.chars.renzo_title)
	Char.renzo.level = str_to_var(save_dict.chars.renzo_level)
	Char.renzo.exp = str_to_var(save_dict.chars.renzo_exp)
	Char.renzo.status = str_to_var(save_dict.chars.renzo_status)
	Char.renzo.head = str_to_var(save_dict.chars.renzo_head)
	Char.renzo.body = str_to_var(save_dict.chars.renzo_body)
	Char.renzo.arms = str_to_var(save_dict.chars.renzo_arms)
	Char.renzo.legs = str_to_var(save_dict.chars.renzo_legs)
	Char.renzo.hand_dx = str_to_var(save_dict.chars.renzo_hand_dx)
	Char.renzo.hand_sx = str_to_var(save_dict.chars.renzo_hand_sx)
	Char.renzo.acc1 = str_to_var(save_dict.chars.renzo_acc1)
	Char.renzo.acc2 = str_to_var(save_dict.chars.renzo_acc2)
	Char.renzo.HP = str_to_var(save_dict.chars.renzo_hp)
	Char.renzo.MP = str_to_var(save_dict.chars.renzo_mp)
	Char.renzo.STRENGHT = str_to_var(save_dict.chars.renzo_str)
	Char.renzo.AGILITY = str_to_var(save_dict.chars.renzo_agi)
	Char.renzo.VIGOR = str_to_var(save_dict.chars.renzo_vig)
	Char.renzo.INTELLECT = str_to_var(save_dict.chars.renzo_int)
	Char.renzo.SPIRIT = str_to_var(save_dict.chars.renzo_spi)
	Char.renzo.cur_HP = str_to_var(save_dict.chars.renzo_cur_hp)
	Char.renzo.cur_MP = str_to_var(save_dict.chars.renzo_cur_mp)
	
	#lucia
	Char.lucia.name = str_to_var(save_dict.chars.lucia_name)
	Char.lucia.title_class = str_to_var(save_dict.chars.lucia_title)
	Char.lucia.level = str_to_var(save_dict.chars.lucia_level)
	Char.lucia.exp = str_to_var(save_dict.chars.lucia_exp)
	Char.lucia.status = str_to_var(save_dict.chars.lucia_status)
	Char.lucia.head = str_to_var(save_dict.chars.lucia_head)
	Char.lucia.body = str_to_var(save_dict.chars.lucia_body)
	Char.lucia.arms = str_to_var(save_dict.chars.lucia_arms)
	Char.lucia.legs = str_to_var(save_dict.chars.lucia_legs)
	Char.lucia.hand_dx = str_to_var(save_dict.chars.lucia_hand_dx)
	Char.lucia.hand_sx = str_to_var(save_dict.chars.lucia_hand_sx)
	Char.lucia.acc1 = str_to_var(save_dict.chars.lucia_acc1)
	Char.lucia.acc2 = str_to_var(save_dict.chars.lucia_acc2)
	Char.lucia.HP = str_to_var(save_dict.chars.lucia_hp)
	Char.lucia.MP = str_to_var(save_dict.chars.lucia_mp)
	Char.lucia.STRENGHT = str_to_var(save_dict.chars.lucia_str)
	Char.lucia.AGILITY = str_to_var(save_dict.chars.lucia_agi)
	Char.lucia.VIGOR = str_to_var(save_dict.chars.lucia_vig)
	Char.lucia.INTELLECT = str_to_var(save_dict.chars.lucia_int)
	Char.lucia.SPIRIT = str_to_var(save_dict.chars.lucia_spi)
	Char.lucia.cur_HP = str_to_var(save_dict.chars.lucia_cur_hp)
	Char.lucia.cur_MP = str_to_var(save_dict.chars.lucia_cur_mp)
	
#event flags
	Global.chest_flags = str_to_var(save_dict.flags.chest)
#inventory
	inv_it.slots = str_to_var(save_dict.items.items)
	inv_ms.slots = str_to_var(save_dict.items.misc)
	inv_we.slots = str_to_var(save_dict.items.weapons)
	inv_ra.slots = str_to_var(save_dict.items.rare)
	inv_eq.slots = str_to_var(save_dict.items.equipped)

	Char.calc_stats()

func load_battle():
	get_tree().change_scene_to_file("res://scenes/battle.tscn")
	
func add_item(item, amount) -> void:
	if item != null:
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
			_:
				pass
		
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
		
#remove item from inventory
func remove_item(item, amount) -> void:
	if item != null:
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

#add item to equip list/inventory
func add_equipped_item(item, amount) -> void:
	var inv_data = preload("res://data/items/inv_equipped.tres")
	var slot = ItemSlot.new()
	slot.item = item
	slot.qnt += amount
	slot.is_locked = true
	inv_data.slots.append(slot)

#remove item from equip list/inventory
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

func play_sfx(stream) -> void:
	$SFX.stream = stream
	$SFX.play()

#game time function
func _physics_process(delta):
	seconds = seconds + delta
	if seconds >= 60:
		seconds = 0
		Global.game_time += 1
