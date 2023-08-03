extends CanvasLayer

var is_on := false
# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox.visible = false
	show()

func _physics_process(_delta):
	if is_on == true:
		if Input.is_action_just_pressed("ui_cancel"):
			exit_menu()


func exit_menu():
	$DialogueBox.visible = false
	Global.playerispaused = false

func dialogue_box(text):
	get_node("DialogueBox/MarginContainer/VBoxContainer/text").text = text
	Global.playerispaused = true
	$DialogueBox.visible = true
	is_on = true
	


