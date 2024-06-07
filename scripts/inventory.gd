extends MarginContainer

const Slot = preload("res://data/items/slot.tscn")
var inv_data = load("res://data/items/testinv.tres")

@onready var item_grid: VBoxContainer = $HBoxContainer/MarginContainer/ItemGrid

func _ready():
	populate_item_grid()
	$HBoxContainer/MarginContainer/ItemGrid.get_child(0).grab_focus()
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	
func populate_item_grid() -> void:
	for child in item_grid.get_children():
		child.queue_free()
	var i = 0
	for item in inv_data.slot_datas:
		var slot = Slot.instantiate()
		if item:
			item_grid.add_child(slot)
			slot.set_slot_data(item, inv_data.slot_datas.values()[i])
			i += 1

func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()

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
	
func _process(delta: float) -> void:
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
