extends PanelContainer

const Slot = preload("res://data/items/slot.tscn")

@onready var item_grid: VBoxContainer = $MarginContainer/ItemGrid

func _ready():
	pass
	
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
