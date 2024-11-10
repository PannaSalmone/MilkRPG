extends MarginContainer

var cur_char : int
var char_list : Array

@onready var item_grid: VBoxContainer = $HBoxContainer/MarginContainer/ItemGrid

func _ready():
	for chara in Global.active_party:
		char_list.append(chara)
	cur_char = 0
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/MarginContainer/PanelContainer/NameBox/Label.text = char_list[cur_char]
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	
func populate_char_panel() -> void:
	pass

func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()
	
func _process(delta: float) -> void:
	#$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	pass
func _on_left_pressed() -> void:
	if cur_char == 0:
		cur_char = char_list.size() - 1
		update_char_info()
	else:
		cur_char -= 1
		update_char_info()
	
func _on_right_pressed() -> void:
	if cur_char == char_list.size() - 1:
		cur_char = 0
		update_char_info()
	else:
		cur_char += 1
		update_char_info()

func update_char_info() -> void:
	$HBoxContainer/MarginContainer/PanelContainer/NameBox/Label.text = char_list[cur_char]
