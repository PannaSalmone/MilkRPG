extends MarginContainer

var swapbank := 20 #variable that stores the name of the character to swap
@onready var desc_panel :=  $HBoxContainer/VBoxContainer/PanelContainer/Text

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
	for chara in Char.active_party:
		if chara:
			var char_slot = slot.instantiate()
			$HBoxContainer/VBoxContainer/PlayerData.add_child(char_slot)
			char_slot.swap.connect(swap)
			char_slot.set_slot_data(chara)
	$HBoxContainer/ButtonPanel/esc.grab_focus()

#Function that swap party member
func swap(id) -> void:
	if swapbank == 20:
		swapbank = id
		desc_panel.text = "Select another character to swap."
	else:
		if id == swapbank:
			swapbank = 20
		else:
			Char.swap_members(id,swapbank)
			swapbank = 20
			populate_chara_data()

func _process(_delta: float) -> void:
	$HBoxContainer/ButtonPanel/Gold/VBoxContainer2/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)

func _on_esc_focus_entered() -> void:
	desc_panel.text = "Close the menu."

func _on_items_focus_entered() -> void:
	desc_panel.text = "Open item menu."

func _on_status_focus_entered() -> void:
	desc_panel.text = "Open status menu."

func _on_equip_focus_entered() -> void:
	desc_panel.text = "Open equip menu."

func _on_save_focus_entered() -> void:
	desc_panel.text = "Save the game."

func _on_option_focus_entered() -> void:
	desc_panel.text = "Open option menu."
