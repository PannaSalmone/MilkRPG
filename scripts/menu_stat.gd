extends MarginContainer

signal close_menu
var cur_char : int
@onready var name_panel := $HBoxContainer/MarginContainer/PanelContainer/NameBox/Label

@onready var name_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/LeftContainer/VBoxContainer/Name
@onready var class_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/LeftContainer/VBoxContainer/Class
@onready var hp_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/HP
@onready var mp_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/MP
@onready var str_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/STR
@onready var vig_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/VIG
@onready var spi_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/SPI
@onready var agi_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/AGI
@onready var int_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/CenterContainer/INT
@onready var atk_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/ATK
@onready var acc_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/ACC
@onready var def_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/DEF
@onready var eva_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/EVA
@onready var mdf_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/MDF
@onready var mpw_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/MPW
@onready var spe_label := $HBoxContainer/MarginContainer/CharInfo/HBoxContainer/RightContainer/SPE


func _ready():
	#create list of active character
	#for chara in Char.active_party:
	cur_char = 0
	$HBoxContainer/ButtonPanel/esc.grab_focus()
	$HBoxContainer/MarginContainer/PanelContainer/NameBox/Label.text = Char.active_party[cur_char].name
	#set gold label 
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Gold/Gold.text = str(Global.gold)
	update_char_info()

func _process(delta: float) -> void:
	$HBoxContainer/ButtonPanel/Info/VBoxContainer/Time/Time.text = str(Global.game_time / 60).pad_zeros(2)+ " : " + str(Global.game_time % 60).pad_zeros(2)
	if Input.is_action_just_pressed("B"):
		emit_signal("close_menu")
	if Input.is_action_just_pressed("R"):
		next_char()
	elif Input.is_action_just_pressed("L"):
		prev_char()

func update_char_info() -> void:
	var char_res = Char.active_party[cur_char] 
	name_panel.text = char_res.name
	%Portrait.texture = char_res.portrait
	hp_label.text = "HP: "+ str(char_res.HP)
	mp_label.text = "MP: "+ str(char_res.MP)
	str_label.text = "STR: "+ str(char_res.STRENGHT)
	vig_label.text = "VIG: "+ str(char_res.VIGOR)
	spi_label.text = "SPI: "+ str(char_res.SPIRIT)
	agi_label.text = "AGI: "+ str(char_res.AGILITY)
	int_label.text = "INT: "+ str(char_res.INTELLECT)
	atk_label.text = "ATK: "+ str(char_res.ATK)
	acc_label.text = "ACC: "+ str(char_res.ACC)
	def_label.text = "DEF: "+ str(char_res.DEF)
	eva_label.text = "EVA: "+ str(char_res.EVA)
	mdf_label.text = "MDF: "+ str(char_res.MDF)
	mpw_label.text = "MPW: "+ str(char_res.MPW)
	spe_label.text = "SPE: "+ str(char_res.SPE)
	name_label.text = char_res.name
	class_label.text = char_res.title_class
	
func next_char() -> void:
	if cur_char == Char.active_party.size() - 1:
		cur_char = 0
		update_char_info()
	else:
		cur_char += 1
		update_char_info()

func prev_char() -> void:
	if cur_char == 0:
		cur_char = Char.active_party.size() - 1
		update_char_info()
	else:
		cur_char -= 1
		update_char_info()

#########Buttons functions
func _on_esc_pressed() -> void:
	emit_signal("close_menu")

func _on_left_pressed() -> void:
	prev_char()

func _on_right_pressed() -> void:
	next_char()
	
