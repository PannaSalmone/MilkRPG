extends Node2D

var playerHP := 100
var enemieHP := 10
# Called when the node enters the scene tree for the first time.
func _ready():
	var char_tex = load("res://sprites/Battle/"+ str(Global.active_member) +"_player.png") #load textures of the active member from the Battle folder
	$Battler/CharSprite.texture = char_tex
	$Enemielife.value = enemieHP
	$Enemielife.max_value = enemieHP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$StatWindow/StatPanel/HBoxContainer/hp1.text = "HP :" + str(playerHP)


func _on_flee_pressed():
	get_tree().change_scene_to_file("res://maps/" +Global.player_map_location+  ".tscn")


func _on_attack_pressed():
	$Enemielife.value -= 5
	$Battler/AnimationPlayer.play("Attack")
	
	
