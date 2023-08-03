extends CanvasLayer

var is_paused := false

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMenu.visible = false
	show()


func _physics_process(_delta):
	if is_paused == true:
		if Input.is_action_just_pressed("ui_cancel"):
			exit_menu()

	if Input.is_action_just_pressed("ui_accept"):
		print(is_paused)
	
	
func exit_menu():
	is_paused = false
	get_tree().paused = false
	$GameMenu.visible = false

func game_menu():
		is_paused = true
		get_tree().paused = true
		$GameMenu.visible = true
		show_data()

func show_data():
	get_node("GameMenu/gold").text = "gold: " + str(Global.gold) #Show the gold amount from Global Var
	get_node("GameMenu/Name1").text = Global.name1

func _on_esc_pressed():
	exit_menu()
	

func _on_save_pressed():
	Utils.save_game()
	
func _on_items_pressed():
	get_node("GameMenu/Name1").text = str(Global.items)



