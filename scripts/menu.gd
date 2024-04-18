extends CanvasLayer

var main_panel := 0 #0 stats #1 items


# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMenu.visible = false
	show()

func _physics_process(_delta):
	if $GameMenu.visible == true:
		if Input.is_action_just_pressed("B"):
			close_menu()

func game_menu():
	get_tree().paused = true
	$GameMenu.visible = true
	load_stat_wind()

func item_panel():
	main_panel = 1
	clean_main_window()
	var inv = load("res://data/items/inventory.tscn")
	var inv_wind = inv.instantiate()
	$GameMenu.add_child(inv_wind)
	

func clean_main_window() -> void:
	var main_wind = $GameMenu
	for child in main_wind.get_children():
		child.queue_free()

func load_stat_wind() -> void:
	main_panel = 0
	var stat = load("res://stat_window.tscn")
	var stat_wind = stat.instantiate()
	$GameMenu.add_child(stat_wind)

func close_menu() -> void:
	if main_panel == 0:
		clean_main_window()
		get_tree().paused = false
		$GameMenu.visible = false
		get_parent().reload_sprite()
	else:
		clean_main_window()
		load_stat_wind()
	

