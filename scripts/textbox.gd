extends CanvasLayer

var writing_time := 0.1
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
			writing_time = 0.0
		else:
			exit_menu()

func exit_menu() -> void:
	Global.is_paused = false
	queue_free()

func write_dialog() -> void:
	var json = FileAccess.open(DIAL_PATH, FileAccess.READ)
	var json_as_text = FileAccess.get_file_as_string(DIAL_PATH)
	var json_as_dict = JSON.parse_string(json_as_text)
	match type:
		0: #NPC
			print("We are number one!")
		1: #Sign
			DIAL_PATH = "res://data/signs.json" 
	dialogue = json_as_dict[index]['testo']
	var name = json_as_dict[index]['nome']
	is_writing = true
	$DialogueBox/MarginContainer/VBoxContainer/name.text = name + ":"
	for lettere in dialogue:
		$DialogueBox/MarginContainer/VBoxContainer/text.text += lettere #str(objname + ": " + dialogue)
		await get_tree().create_timer(writing_time).timeout
	is_writing = false
	
func chest(dialogue) -> void:
	is_writing = true
	for lettere in dialogue:
		$DialogueBox/MarginContainer/VBoxContainer/text.text += lettere #str(objname + ": " + dialogue)
		await get_tree().create_timer(writing_time).timeout
	is_writing = false
