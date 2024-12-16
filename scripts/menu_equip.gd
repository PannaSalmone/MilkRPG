extends MarginContainer

signal close_menu
var page_num : int
var cur_char : Resource
var loaded_equipment : Array
var item_selected : int
var item_sel_page := false

@onready var equip_list := $HBoxContainer/MarginContainer/SelectPanel/EquipPanel/ScrollContainer/EquipListContainer/EquipList
@onready var char_select_panel := $HBoxContainer/MarginContainer/CharSelectPanel
@onready var main_panel := $HBoxContainer/MarginContainer/MainPanel
@onready var select_panel := $HBoxContainer/MarginContainer/SelectPanel
@onready var portrait: TextureRect = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/MarginContainer/TextureRect

func _ready():
	page_num = 0
	load_main_window()
	update_char_info()
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)	

func _process(_delta: float) -> void:
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	if Input.is_action_just_pressed("B"):
		back()
	if item_sel_page != true:
		if Input.is_action_just_pressed("R"):
			next_char()
		elif Input.is_action_just_pressed("L"):
			prev_char()


func prev_char() -> void:
	if page_num == 0:
		page_num = Char.active_party.size() - 1
		update_char_info()
	else:
		page_num -= 1
		update_char_info()

func next_char() -> void:
	if page_num == Char.active_party.size() - 1:
		page_num = 0
		update_char_info()
	else:
		page_num += 1
		update_char_info()

func update_char_info() -> void:
	cur_char = Char.active_party[page_num]
	$HBoxContainer/MarginContainer/CharSelectPanel/NameBox/Label.text = cur_char.name
	portrait.texture = cur_char.portrait
	load_equip()

func load_equip() -> void:
	var equipment_panel := $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Column1/EquipPanel
	var buttons = equipment_panel.get_children()
	loaded_equipment = cur_char.equipment
	var i = 0
	for item in loaded_equipment:
		if item != null:
			buttons[i].get_node("MarginContainer/HBoxContainer/name").text = item.name
			buttons[i].get_node("MarginContainer/HBoxContainer/icon").texture = item.icon
			i += 1
		else:
			buttons[i].get_node("MarginContainer/HBoxContainer/name").text = "no item"
			buttons[i].get_node("MarginContainer/HBoxContainer/icon").texture = null
			i += 1

func open_equipment_menu(type : String) -> void:
	item_sel_page = true
	load_equip_menu()
	clear_equip_list()
	var inv = load("res://data/items/inv_weap.tres")
	var inv_data = inv.slots
	var Slot = load("res://scenes/menu/equip_slot.tscn")
	match type:
		"weap":
			for items in inv_data:
				if items.item.type == "weap":
					var itemslot = Slot.instantiate()
					equip_list.add_child(itemslot)
					itemslot.set_equip_data(items)
					itemslot.connect("item_focused", Callable(self, "on_item_focused"))
					itemslot.connect("item_selected",Callable(self, "on_item_selected"))
		"head":
			for items in inv_data:
				if items.item.type == "armor" and items.item.armor_type == "head":
					var itemslot = Slot.instantiate()
					equip_list.add_child(itemslot)
					itemslot.set_equip_data(items)
					print(items)
		"body":
			for items in inv_data:
				if items.item.type == "armor" and items.item.armor_type == "body":
					var itemslot = Slot.instantiate()
					equip_list.add_child(itemslot)
					itemslot.set_equip_data(items)
					print(items)
	if equip_list.get_child_count() == 0:
		var itemslot = Slot.instantiate()
		equip_list.add_child(itemslot)
		itemslot.no_item()
	equip_list.get_child(0).grab_focus()

func set_selected_item_info() -> void:
	if loaded_equipment[item_selected] != null:
		%SelIcon.texture = loaded_equipment[item_selected].icon
		%SelName.text = loaded_equipment[item_selected].name
	else:
		#%SelIcon.texture = item_selected.icon
		%SelName.text = "No Item"

func clear_equip_list() -> void:
	var children = equip_list.get_children()
	for c in children:
		c.free()

func back() -> void:
	if item_sel_page == true:
		load_main_window()
	else:
		emit_signal("close_menu")

func load_main_window() -> void:
	item_sel_page = false
	main_panel.show()
	char_select_panel.show()
	select_panel.hide()
	$HBoxContainer/ButtonPanel/esc.grab_focus()

func load_equip_menu() -> void:
	main_panel.hide()
	char_select_panel.hide()
	select_panel.show()

###################################button functions########################################
func _on_head_pressed() -> void:
	var equip = cur_char.equipment
	item_selected = 0
	open_equipment_menu("head")
	set_selected_item_info()

func _on_dx_pressed() -> void:
	var equip = cur_char.equipment
	item_selected = 1
	open_equipment_menu("weap")
	set_selected_item_info()
	
func _on_body_pressed() -> void:
	var equip = cur_char.equipment
	item_selected = 2
	open_equipment_menu("body")
	set_selected_item_info()

func _on_sx_pressed() -> void:
	var equip = cur_char.equipment
	item_selected = 3
	open_equipment_menu("weap")
	set_selected_item_info()

func _on_left_pressed() -> void:
	prev_char()

func _on_right_pressed() -> void:
	next_char()

func _on_esc_pressed() -> void:
	back()

#############Signal functions
func on_item_focused(desc):
	%Description.text = desc
 
func on_item_selected(item_res) -> void:
	Utils.remove_item_equipped(loaded_equipment[item_selected])
	loaded_equipment[item_selected] = item_res
	Utils.add_equipped_item(item_res, 1)
	Utils.remove_item(item_res, 1)
	
	update_char_info()
	load_main_window()
