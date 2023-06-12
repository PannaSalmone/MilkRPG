extends CanvasLayer

var is_paused := false
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		unpause()

func unpause():
	is_paused = false
	get_tree().paused = false
	hide()

func pause():
		is_paused = true
		get_tree().paused = true
		show_data()
		show()

func _on_esc_pressed():
	hide()
	get_tree().paused = false


#func _on_save_pressed():
#	var gold2 = Save_Data.new()	
#	var script = load("res://scripts/save_game.gd").new()
#	script.write_save_game()
	
func show_data():
	get_node("Panel/gold").text = "gold: " + str(Global.gold) #Show the gold amount from Global Var
	get_node("Panel/Name1").text = Global.name1
	
	
	
