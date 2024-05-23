extends CanvasLayer

var writing_skip := false
var is_writing := false
var DIAL_PATH = "res://data/dialogues.json" 
var dialogue = {}
var index : int
var type := 0 #0 npc, 1 sign

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.is_paused = true

func _physics_process(_delta)-> void:
	if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("A") :
		if is_writing == true:
			writing_skip = true
		else:
			exit_menu()

func exit_menu() -> void:
	Global.is_paused = false
	queue_free()

func write_dialog() -> void:	
	match type:
		0: #NPC
			print("We are number one!")
		1: #Sign
			DIAL_PATH = "res://data/signs.json" 
	var json = FileAccess.open(DIAL_PATH, FileAccess.READ)
	var json_as_text = FileAccess.get_file_as_string(DIAL_PATH)
	var json_as_dict = JSON.parse_string(json_as_text)
	dialogue = json_as_dict[index]['testo']
	var npc_name = json_as_dict[index]['nome']
	is_writing = true
	$DialogueBox/MarginContainer/VBoxContainer/name.text = npc_name + ":"
	for lettere in dialogue:
		$DialogueBox/MarginContainer/VBoxContainer/text.text += lettere #str(objname + ": " + dialogue)
		if writing_skip == false:
			await get_tree().create_timer(0.05).timeout
	is_writing = false
	
func chest(dialogue) -> void:
	is_writing = true
	for lettere in dialogue:
		$DialogueBox/MarginContainer/VBoxContainer/text.text += lettere #str(objname + ": " + dialogue)
		if writing_skip == false:
			await get_tree().create_timer(0.05).timeout
	is_writing = false
