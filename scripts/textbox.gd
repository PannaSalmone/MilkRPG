extends CanvasLayer

var writing_skip := false
var is_writing := false
var DIAL_PATH = "res://data/dialogues.json" 
var dialogue = {}
var index : int
var type := 0 #0 npc, 1 sign, 2 chest
var cur_line := 1
var json_as_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.is_paused = true

func _physics_process(_delta)-> void:
	if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("A") :
		if is_writing == true:
			writing_skip = true
		else:
			if type == 2: #if is a chest
				exit_menu()
			elif json_as_dict[index].has("line"+ str(cur_line)):#check if exist another line of text
				writing_skip = false
				$DialogueBox/MarginContainer/VBoxContainer/text.text = ""
				write_dialog()
			else:
				exit_menu()

func exit_menu() -> void:
	Global.is_paused = false
	queue_free()

func write_dialog() -> void:
	if json_as_dict.is_empty():
		parsetext()
	dialogue = json_as_dict[index]["line"+ str(cur_line)]
	var npc_name = json_as_dict[index]['nome']
	is_writing = true
	$DialogueBox/MarginContainer/VBoxContainer/name.text = npc_name + ":"
	for lettere in dialogue:
		$DialogueBox/MarginContainer/VBoxContainer/text.text += lettere #str(objname + ": " + dialogue)
		if writing_skip == false:
			await get_tree().create_timer(0.05).timeout
	cur_line += 1
	is_writing = false
	
	
func chest(text) -> void:
	is_writing = true
	type = 2
	for lettere in text:
		$DialogueBox/MarginContainer/VBoxContainer/text.text += lettere #str(objname + ": " + dialogue)
		if writing_skip == false:
			await get_tree().create_timer(0.05).timeout
	is_writing = false

func parsetext() -> void:
	if type == 1:
		DIAL_PATH = "res://data/signs.json" 
	var json = FileAccess.open(DIAL_PATH, FileAccess.READ)
	var json_as_text = FileAccess.get_file_as_string(DIAL_PATH)
	json_as_dict = JSON.parse_string(json_as_text)
	print("parsed")
	
