extends MarginContainer

var swapbank = "" #variable that stores the name of the character to swap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_chara_data()
	$HBoxContainer/ButtonPanel/Gold/VBoxContainer2/Gold/Gold.text = str(Global.gold)


######################################  Button funcs
func _on_save_pressed() -> void:
	Utils.save_game()

#TODO use signal instead
func _on_items_pressed() -> void:
	get_parent().get_parent().item_panel()

func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()
	
func _on_option_pressed() -> void:
	get_parent().get_parent().option_panel()

func _on_status_pressed() -> void:
	get_parent().get_parent().status_panel()
	
func _on_equip_pressed() -> void:
	get_parent().get_parent().equip_panel()


#load character data and info in the main panel
func populate_chara_data() -> void:
	for child in $HBoxContainer/VBoxContainer/PlayerData.get_children():
		child.queue_free()
	var slot = load("res://scenes/menu/menu_character_slot.tscn")
	for chara in Global.active_party:
		var char_slot = slot.instantiate()
		if chara:
			$HBoxContainer/VBoxContainer/PlayerData.add_child(char_slot)
			char_slot.swap.connect(swap)
			char_slot.set_slot_data(load("res://data/chars/"+ chara+".tres"))
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	

#Function that swap party member
func swap(selected) -> void:
	print("Selected: " + selected)
	print("swapbank: " + swapbank)
	if swapbank == "":
		swapbank = selected
		$HBoxContainer/VBoxContainer/PanelContainer/Text.text = "Select another character to swap."
	else:
		if selected == swapbank:
			swapbank = ""
		else:
			Global.active_party[Global.active_party.find(selected)] = "temp"
			Global.active_party[Global.active_party.find(swapbank)] = selected
			Global.active_party[Global.active_party.find("temp")] = swapbank
			swapbank = ""
			populate_chara_data()

func _process(delta: float) -> void:
	$HBoxContainer/ButtonPanel/Gold/VBoxContainer2/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
