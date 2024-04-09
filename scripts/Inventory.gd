extends MarginContainer

const Slot = preload("res://data/items/slot.tscn")

@onready var item_grid: VBoxContainer = $HBoxContainer/MarginContainer/ItemGrid

func _ready():
	populate_item_grid()
	$HBoxContainer/MarginContainer/ItemGrid.get_child(0).grab_focus()
	$HBoxContainer/ButtonPanel/Gold/gold.text = str(Global.gold)
	
func populate_item_grid() -> void:
	var inv_data = load("res://data/items/testinv.tres")
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
