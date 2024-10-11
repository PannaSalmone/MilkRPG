extends CanvasLayer

var writing_skip := false
var is_writing := false
var is_finished := false
var type := 0 #0 npc, 1 sign, 2 chest
var cur_line := 0
var dial_res : Resource
var simple_text : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass

func _physics_process(_delta)-> void:
	if Input.is_action_just_pressed("B") or Input.is_action_just_pressed("A") :
		if is_writing == true:
			writing_skip = true
		else:
			if type == 0:
				parse_dialog()
			else:
				exit_menu()

func exit_menu() -> void:
	Global.is_paused = false
	queue_free()

func parse_dialog():
	if cur_line  != dial_res.dialogue.size():
		var line_type = dial_res.dialogue[cur_line].left(2)
		match line_type:
			">>" : #dialogue line
				write_dialog(dial_res.dialogue[cur_line].lstrip(">>"))
				#cur_line += 1
			"n/": #change name in the name box
				var new_name = dial_res.dialogue[cur_line].lstrip("n/")
				$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer2/name.text = new_name
				cur_line += 1
				parse_dialog()
			"p/": #change portrait picture in the textbox
				if dial_res.dialogue[cur_line].lstrip("p/") == "no":
					$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer2/port.texture = null
				else:
					var new_port = load("res://sprites/portraits/"+ (dial_res.dialogue[cur_line].lstrip("p/"))+ ".png")
					print(new_port)
					$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer2/port.texture = new_port
				cur_line += 1
				parse_dialog()
	else:
		exit_menu()

func write_dialog(line) -> void:
	#print text from resources
	is_writing = true
	writing_skip = false
	$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer/text.text = ""
	for lettere in line:
		$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer/text.text += lettere
		if writing_skip == false:
			await get_tree().create_timer(0.05).timeout
	is_writing = false
	cur_line += 1

func npc() -> void:
	type = 0 #npc
	Global.is_paused = true
	dial_res = get_parent().dialogue
	#draw NPC portraits from dialogue resources + name
	if dial_res.portrait != null:
		$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer2/port.texture = dial_res.portrait
	if dial_res.obj_name != "":
		$DialogueBox/MarginContainer/HBoxContainer/VBoxContainer2/name.text = dial_res.obj_name + ":"
	parse_dialog()

func sign() -> void:
	type = 1 #sign
	Global.is_paused = true
	write_dialog(simple_text)

func chest(text) -> void:
	type = 2 #chest
	Global.is_paused = true
	write_dialog(text)



	
