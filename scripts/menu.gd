extends CanvasLayer
var is_paused := false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/GameMenu.visible = false
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
	$MarginContainer/GameMenu.visible = false

func game_menu():
		is_paused = true
		get_tree().paused = true
		$MarginContainer/GameMenu.visible = true
		show_data()
		

func show_data():
	var char1data := load("res://data/chars/1.tres")
	get_node("MarginContainer/GameMenu/gold").text = "gold: " + str(Global.gold) #Show the gold amount from Global Var
	get_node("MarginContainer/GameMenu/Name1").text = Global.name1
	get_node("MarginContainer/GameMenu/Port1").texture = char1data.portrait
	get_node("MarginContainer/GameMenu/HP1").text = "HP" + str(Global.hp1) + "/" + str(char1data.HP)

func _on_esc_pressed():
	exit_menu()
	

func _on_save_pressed():
	Utils.save_game()
	
func _on_items_pressed():
	$MarginContainer/GameMenu/Name1.hide()
	$MarginContainer/GameMenu/HP1.hide()
	$MarginContainer/GameMenu/Port1.hide()
	$MarginContainer/GameMenu/press.hide()
	$MarginContainer/GameMenu/gold.hide()
	$MarginContainer/GameMenu/Inventory.show()
	$MarginContainer/GameMenu/Inventory.populate_item_grid()
	#get_node("GameMenu/Name1").text = str(Global.items.values())
	



