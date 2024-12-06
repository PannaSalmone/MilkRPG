extends MarginContainer

var page_num : int
var cur_char : Resource

@onready var portrait: TextureRect = $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/MarginContainer/TextureRect

func _ready():
	page_num = 0
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	update_char_info()

func populate_char_panel() -> void:
	pass

func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()
	
func _process(_delta: float) -> void:
	#$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	pass
func _on_left_pressed() -> void:
	if page_num == 0:
		page_num = Char.active_party.size() - 1
		update_char_info()

	else:
		page_num -= 1
		update_char_info()
	
func _on_right_pressed() -> void:
	if page_num == Char.active_party.size() - 1:
		page_num = 0
		update_char_info()

	else:
		page_num += 1
		update_char_info()


func update_char_info() -> void:
	cur_char = Char.active_party[page_num]
	$HBoxContainer/MarginContainer/PanelContainer/NameBox/Label.text = cur_char.name
	portrait.texture = cur_char.portrait
	load_equip()

func load_equip() -> void:
	var buttons = %MarginContainer2.get_children()
	var equip = cur_char.equipment
	var i = 0
	for item in equip:
		if item != null:
			buttons[i].get_node("MarginContainer/HBoxContainer/name").text = item.name
			buttons[i].get_node("MarginContainer/HBoxContainer/icon").texture = item.icon
			i += 1
		else:
			buttons[i].get_node("MarginContainer/HBoxContainer/name").text = "no item"
			buttons[i].get_node("MarginContainer/HBoxContainer/icon").texture = null
			i += 1



		
	
	
	
	
