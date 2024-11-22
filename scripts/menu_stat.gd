extends MarginContainer

var cur_char : int
var char_list : Array
@onready var name_panel := $HBoxContainer/MarginContainer/PanelContainer/NameBox/Label


func _ready():
	#create list of active character
	for chara in Global.active_party:
		char_list.append(chara)
	cur_char = 0
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/MarginContainer/PanelContainer/NameBox/Label.text = char_list[cur_char]
	#set gold label 
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	update_char_info()
	


func _on_esc_pressed() -> void:
	get_parent().get_parent().close_menu()
	
func _process(delta: float) -> void:
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	if Input.is_action_just_pressed("R"):
		next_char()
	elif Input.is_action_just_pressed("L"):
		prev_char()
		
func _on_left_pressed() -> void:
	prev_char()

func _on_right_pressed() -> void:
	next_char()

func update_char_info() -> void:
	var char_res = load("res://data/chars/"+ char_list[cur_char] +".tres")
	name_panel.text = char_res.name
	%Portrait.texture = char_res.portrait
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/Name.text = char_res.name + " " + char_res.surname
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/Class.text = char_res.title_class
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/HP.text = "HP: " + str(char_res.HP)
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/STR.text = "STR: " + str(char_res.STRENGHT)
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/VIG.text = "VIG: " + str(char_res.VIGOR)
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/SPI.text = "SPI: " + str(char_res.SPIRIT)
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/MP.text = "MP: " + str(char_res.MP)
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/SPE.text = "SPE: " + str(char_res.SPEED)
	$HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/INT.text = "INT: " + str(char_res.INTELLECT)
	
func next_char() -> void:
	if cur_char == char_list.size() - 1:
		cur_char = 0
		update_char_info()
	else:
		cur_char += 1
		update_char_info()

func prev_char() -> void:
	if cur_char == 0:
		cur_char = char_list.size() - 1
		update_char_info()
	else:
		cur_char -= 1
		update_char_info()
