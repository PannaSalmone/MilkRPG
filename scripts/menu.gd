extends CanvasLayer

var cur_panel := 0 #0 stats #1 items #2 options #3 status #4 equip


# Called when the node enters the scene tree for the first time.
func _ready():
	$GameMenu.visible = false
	show()

func _physics_process(_delta):
	#if Input.is_action_just_pressed("B"):
	#	close_menu()
	pass

func game_menu():
	get_tree().paused = true
	$GameMenu.visible = true
	load_stat_wind()

func item_panel():
	cur_panel = 1
	clean_main_window()
	var inv = load("res://scenes/menu/inventory.tscn")
	var inv_wind = inv.instantiate()
	$GameMenu.add_child(inv_wind)
	inv_wind.connect("close_menu",Callable(self, "on_close_menu"))

func option_panel() -> void:
	cur_panel = 2
	clean_main_window()
	var opz = load("res://scenes/menu/options.tscn")
	var opz_wind = opz.instantiate()
	$GameMenu.add_child(opz_wind)
	opz_wind.connect("close_menu",Callable(self, "on_close_menu"))

func status_panel() -> void:
	cur_panel = 3
	clean_main_window()
	var stat = load("res://scenes/menu/stat_menu.tscn")
	var stat_wind = stat.instantiate()
	$GameMenu.add_child(stat_wind)
	stat_wind.connect("close_menu",Callable(self, "on_close_menu"))
	
func equip_panel() -> void:
	cur_panel = 4
	clean_main_window()
	var equip = load("res://scenes/menu/equip_menu.tscn")
	var equip_wind = equip.instantiate()
	$GameMenu.add_child(equip_wind)
	equip_wind.connect("close_menu",Callable(self, "on_close_menu"))

func clean_main_window() -> void:
	var main_wind = $GameMenu
	for child in main_wind.get_children():
		child.queue_free()

func load_stat_wind() -> void:
	cur_panel = 0
	var main = load("res://scenes/menu/main_window.tscn")
	var main_wind = main.instantiate()
	$GameMenu.add_child(main_wind)

func close_menu() -> void:
	if cur_panel == 0:
		clean_main_window()
		get_tree().paused = false
		$GameMenu.visible = false
		get_parent().reload_sprite()
	else:
		clean_main_window()
		load_stat_wind()

func on_close_menu():
	close_menu()
