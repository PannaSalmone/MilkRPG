extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slot = load("res://menu_character_slot.tscn")
	for chara in Global.active_party:
		var char_slot = slot.instantiate()
		if chara:
			$HBoxContainer/PlayerData.add_child(char_slot)
			char_slot.set_slot_data(load("res://data/chars/"+ chara+".tres"))
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/ButtonPanel/Gold/gold.text = str(Global.gold)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

#Button funcs
func _on_save_pressed() -> void:
	Utils.save_game()

func _on_items_pressed() -> void:
	get_parent().get_parent().item_panel()

func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()
