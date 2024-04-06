extends Node2D

var playerHP : int = 100
var enemieHP : int = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	var enemie_data = load("res://data/enemies/green_dragon.tres")
	var char_tex = load("res://sprites/Battle/"+ str(Global.active_member) +"_player.png") #load textures of the active member from the Battle folder
	print("a " + enemie_data.name + " appeared!")
	$Battler/CharSprite.texture = char_tex
	enemieHP = enemie_data.HP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Enemielife.value = enemieHP
	$Enemielife/HP.text = str(enemieHP)
	$StatWindow/StatPanel/HBoxContainer/hp1.text = "HP :" + str(playerHP)
	if $Enemielife.value == 0:
		display_text("U win")
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")

func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text


func _on_flee_pressed():
		get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")


func _on_attack_pressed():
	enemieHP -= 40
	if enemieHP < 0:
		enemieHP = 0
	$Battler/AnimationPlayer.play("Attack")
	
	
	
