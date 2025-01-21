extends MarginContainer

signal close_menu
var page_num : int
var item_sel_type : String
var item_selected : DataItem
var item_sel_page := false
var loaded_char : Resource

@onready var equip_list := $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/ItemPanel/EquipPanel/ScrollContainer/EquipListContainer/EquipList
@onready var char_select_panel := $HBoxContainer/MarginContainer/CharSelectPanel
@onready var equip_panel := $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment
@onready var select_panel := $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/ItemPanel
@onready var portrait: TextureRect = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/CharacterInfo/VBoxContainer/TextureRect
@onready var atk_label: Label = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/CharacterInfo/VBoxContainer/ATK
@onready var def_label: Label = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/CharacterInfo/VBoxContainer/DEF

@onready var head_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/Head
@onready var body_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/Body
@onready var arms_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/Arms
@onready var legs_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/Legs
@onready var handdx_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/DX
@onready var handsx_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/SX
@onready var acc1_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/Acc1
@onready var acc2_slot :Button = $HBoxContainer/MarginContainer/MainPanel/HBoxContainer/Equipment/EquipPanel/Acc2

func _ready():
	page_num = 0
	update_char_info()
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
	%test.text = str(item_selected)


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
	loaded_char = Char.active_party[page_num]
	Char.selected_char = loaded_char
	$HBoxContainer/MarginContainer/CharSelectPanel/NameBox/Label.text = loaded_char.name
	portrait.texture = loaded_char.portrait
	Char.update_stats(loaded_char)
	update_labels()
	load_equip()

func load_equip() -> void:
	var cur_char = Char.active_party[page_num]
	if cur_char.head != null:
		head_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.head.name
		head_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.head.icon
	else:
		head_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		head_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	if cur_char.body != null:
		body_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.body.name
		body_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.body.icon
	else:
		body_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		body_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null	
	if cur_char.arms != null:
		arms_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.arms.name
		arms_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.arms.icon
	else:
		arms_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		arms_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	if cur_char.legs != null:
		legs_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.legs.name
		legs_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.legs.icon
	else:
		legs_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		legs_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	if cur_char.hand_dx != null:
		handdx_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.hand_dx.name
		handdx_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.hand_dx.icon
	else:
		handdx_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		handdx_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	if cur_char.hand_sx != null:
		handsx_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.hand_sx.name
		handsx_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.hand_sx.icon
	else:
		handsx_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		handsx_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	if cur_char.acc1 != null:
		acc1_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.acc1.name
		acc1_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.acc1.icon
	else:
		acc1_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		acc1_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	if cur_char.acc2 != null:
		acc2_slot.get_node("MarginContainer/HBoxContainer/name").text = cur_char.acc2.name
		acc2_slot.get_node("MarginContainer/HBoxContainer/icon").texture = cur_char.acc2.icon
	else:
		acc2_slot.get_node("MarginContainer/HBoxContainer/name").text = "no item"
		acc2_slot.get_node("MarginContainer/HBoxContainer/icon").texture = null
	
func open_equipment_menu(type : String) -> void:
	item_sel_page = true
	clear_equip_list()
	load_equip_menu()
	var Slot = load("res://scenes/menu/equip_slot.tscn")
	var removeslot = Slot.instantiate()
	equip_list.add_child(removeslot)
	removeslot.no_equip = true
	removeslot.connect("remove_item", Callable(self, "on_item_removed"))
	removeslot.no_item()
	equip_list.get_child(0).grab_focus()
	var inv = load("res://data/items/inv_weap.tres")
	var inv_data = inv.slots
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
					itemslot.connect("item_focused", Callable(self, "on_item_focused"))
					itemslot.connect("item_selected",Callable(self, "on_item_selected"))
		"body":
			for items in inv_data:
				if items.item.type == "armor" and items.item.armor_type == "body":
					var itemslot = Slot.instantiate()
					equip_list.add_child(itemslot)
					itemslot.set_equip_data(items)
					itemslot.connect("item_focused", Callable(self, "on_item_focused"))
					itemslot.connect("item_selected",Callable(self, "on_item_selected"))

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
	equip_panel.show()
	char_select_panel.show()
	select_panel.hide()
	$HBoxContainer/ButtonPanel/esc.grab_focus()

func load_equip_menu() -> void:
	equip_panel.hide()
	#char_select_panel.hide()
	select_panel.show()

func update_labels() -> void:
	atk_label.text = "Atk: " + str(loaded_char.ATK)
	def_label.text = "Def: " + str(loaded_char.DEF)

###################################button functions########################################
func _on_head_pressed() -> void:
	item_sel_type = "head"
	item_selected = loaded_char.head
	open_equipment_menu("head")
	

func _on_dx_pressed() -> void:
	item_selected = loaded_char.hand_dx
	open_equipment_menu("weap")
	item_sel_type = "hand_dx"
	
func _on_body_pressed() -> void:
	item_selected = loaded_char.body
	open_equipment_menu("body")
	item_sel_type = "body"

func _on_sx_pressed() -> void:
	item_selected = loaded_char.hand_sx
	open_equipment_menu("weap")
	item_sel_type = "hand_sx"

func _on_left_pressed() -> void:
	prev_char()

func _on_right_pressed() -> void:
	next_char()

func _on_esc_pressed() -> void:
	back()

#############Signal functions#######################
func on_item_focused(desc):
	%Description.text = desc
 
func on_item_selected(item_res) -> void:
		if item_selected != null:
			Utils.remove_item_equipped(item_selected)
		Char.add_equipment(item_sel_type, item_res)
		Utils.add_equipped_item(item_res, 1)
		Utils.remove_item(item_res, 1)
		update_char_info()
		load_main_window()
		%SelectedItem.text = ""
		
		
func on_item_removed() -> void:
		Char.remove_equipment(item_sel_type)
		Utils.remove_item_equipped(item_selected)
		update_char_info()
		load_main_window()

#############Focus signals
func _on_head_focus_entered() -> void:
	%Description.text = "Head"

func _on_dx_focus_entered() -> void:
	%Description.text = "Hand DX"

func _on_body_focus_entered() -> void:
	%Description.text = "Body"

func _on_sx_focus_entered() -> void:
		%Description.text = "Hand SX"
		
func _on_legs_focus_entered() -> void:
		%Description.text = "Legs"

func _on_acc_1_focus_entered() -> void:
		%Description.text = "Accessory 1"

func _on_arms_focus_entered() -> void:
		%Description.text = "Arms"

func _on_acc_2_focus_entered() -> void:
		%Description.text = "Accessory 2"

func _on_esc_focus_entered() -> void:
	%Description.text = "Close Equipment menu"
