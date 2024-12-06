extends MarginContainer

const Slot = preload("res://scenes/menu/slot.tscn")
var inv_data = load("res://data/items/inv_items.tres") #Current inventory 
var cur_page := 0 #0 items, 1 weap, 2 misc, 3 rare 
var selected_item 
var char_panel = false

@onready var item_panel: Label = $HBoxContainer/MarginContainer/PanelContainer/Items/Label
@onready var weap_panel: Label = $HBoxContainer/MarginContainer/PanelContainer/Weap/Label
@onready var misc_panel: Label = $HBoxContainer/MarginContainer/PanelContainer/Misc/Label
@onready var rare_panel: Label = $HBoxContainer/MarginContainer/PanelContainer/Key/Label
@onready var item_list: VBoxContainer = $HBoxContainer/MarginContainer/ItemList/ItemContainer
@onready var chars_list :VBoxContainer = $HBoxContainer/MarginContainer/ItemList/CharaContainer

func _ready():
	$HBoxContainer/MarginContainer/ItemList/CharaContainer.hide()
	populate_item_grid()
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	focus()
	$HBoxContainer/ButtonPanel/use.disabled = true

func _process(_delta: float) -> void:
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	if Input.is_action_just_pressed("R"):
		next_cat()
	elif Input.is_action_just_pressed("L"):
		prev_cat()

#Load inventory and add item_slot into the item grid/list
func populate_item_grid() -> void:
	var children = item_list.get_children()
	for c in children:
		c.free()
	var i = 0
	for item in inv_data.slot_datas:
		var slot = Slot.instantiate()
		if item:
			item_list.add_child(slot)
			slot.set_slot_data(item, inv_data.slot_datas.values()[i])
			#connect signal from generated childs
			slot.connect("item_focused", Callable(self, "on_item_focused"))
			slot.connect("item_selected",Callable(self, "on_item_selected"))
			i += 1

func _on_sort_pressed() -> void: #It just works
	var array := [] #for sort items name, Dictionary cannot be sorted
	var new_dict := {} #temp dictionary for host res as key and name as value
	var new_inv := {} #temp dictionary for host res as key and quantity as value
	for key in inv_data.slot_datas:
		new_dict[key] = key.name
#create an array with only the items name and sort it in alphabetic order
		array.append(key.name) 
		array.sort()
#create new dictionary with same structure as the inventory one but with elements sorted by names
	for itemname in array: 
		new_inv[new_dict.find_key(itemname)] = inv_data.slot_datas.get(new_dict.find_key(itemname))
		pass
	inv_data.slot_datas = new_inv
	populate_item_grid()

#use item func
func _on_use_pressed() -> void:
	if selected_item:
		item_used() # Decrease the quantity of the selected item
	if selected_item.category == 0:
		var item_func = selected_item.function
		match item_func:
			0: #Recover HP
				print("recover " +str(selected_item.power) +" HP mlmlm")
				open_chars_list()
			1:# Recover MP
				pass
			"_":
				pass
	$HBoxContainer/ButtonPanel/use.disabled = true


func _on_esc_pressed() -> void:
	if char_panel == false:
		get_parent().get_parent().close_menu()
	else:
		return_to_item_page()
		

func _on_left_pressed() -> void:
	prev_cat()

func _on_right_pressed() -> void:
	next_cat()

func focus() -> void:
	if item_list.get_child_count() > 0:
		item_list.get_child(0).grab_focus()
	else:
		$HBoxContainer/ButtonPanel/esc.grab_focus()

func load_inv() -> void:
	item_panel.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))
	weap_panel.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))
	misc_panel.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))
	rare_panel.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6, 1))
	match cur_page:
		0: 
			inv_data = load("res://data/items/inv_items.tres")
			item_panel.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		1: 
			inv_data = load("res://data/items/inv_weap.tres")
			weap_panel.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		2: 
			inv_data = load("res://data/items/inv_misc.tres")
			misc_panel.add_theme_color_override("font_color", Color(1, 1, 1, 1))
		3: 
			inv_data = load("res://data/items/inv_rare.tres")
			rare_panel.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	populate_item_grid()
	focus()

func prev_cat() -> void: #move to prev item category
	if cur_page == 0:
		cur_page = 3
	else:
		cur_page -= 1
	load_inv()

func next_cat() -> void: #move to next item category
	if cur_page == 3:
		cur_page = 0
	else:
		cur_page += 1
	load_inv()

#Signals from Item slots
func on_item_focused(desc):
	%Description.text = desc
 
func on_item_selected(item_res) -> void:
	selected_item = item_res
	if cur_page == 0:
		print(selected_item)
		$HBoxContainer/ButtonPanel/use.disabled = false
		$HBoxContainer/ButtonPanel/use.grab_focus()

func open_chars_list() -> void:
	char_panel = true
	item_list.hide()
	chars_list.show()
	$HBoxContainer/ButtonPanel/sort.disabled = true
	#populate char panel
	free_char_slots()
	var slot = load("res://scenes/menu/menu_character_slot.tscn")
	for chara in Char.active_party:
		var char_slot = slot.instantiate()
		if chara:
			chars_list.add_child(char_slot)
			char_slot.set_slot_data(load("res://data/chars/"+ chara+".tres"))
			char_slot.connect("selected_char", Callable(self, "on_char_selected"))
	chars_list.get_child(0).grab_focus()
	%Description.text = "select character you want to use item on"
	$HBoxContainer/ButtonPanel/esc.text = "Back"
	
func on_char_selected(character) -> void:
	#use item
	print("potion used on " + str(character))
	return_to_item_page()
	pass

func free_char_slots() -> void:
	for child in chars_list.get_children():
		child.queue_free()

func return_to_item_page() -> void:
	free_char_slots()
	chars_list.hide()
	item_list.show()
	$HBoxContainer/ButtonPanel/esc.text = "Close"
	$HBoxContainer/ButtonPanel/sort.disabled = false
	populate_item_grid()
	focus()

func item_used() -> void:
	inv_data.slot_datas[selected_item] -= 1
	# If the quantity reaches zero, remove the item from the inventory
	if inv_data.slot_datas[selected_item] <= 0:
		inv_data.slot_datas.erase(selected_item)
	
