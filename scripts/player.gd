extends CharacterBody2D

@export var speed: int = 200
@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
var collider
var is_moving = false #used for battle encounter counter

func _ready():
	$RayCast2D.target_position = Global.raycast_direction #Globalized Raycast2d target
	position = Global.player_xy #Position set in global script and updated with warp script
	anim_tree.set("parameters/Idle/blend_position" , $RayCast2D.target_position)
	reload_sprite()
	
	
func get_input():
	if Global.is_paused == false:
		var input_direction = Input.get_vector("D_Left", "D_Right", "D_Up", "D_Down")
		if input_direction != Vector2.ZERO:
			is_moving = true
			$RayCast2D.target_position = input_direction * 28#32 raycast lenght	
			Global.raycast_direction = $RayCast2D.target_position #Raycast direction going global
			anim_tree.set("parameters/Idle/blend_position" , input_direction)
			anim_tree.set("parameters/Walk/blend_position" , input_direction)
			anim_state.travel("Walk")
			velocity = input_direction * speed
		else:
			anim_state.travel("Idle")
			velocity = Vector2.ZERO
			is_moving = false
		if Input.is_action_pressed("B"):
			speed = 350
		else:
			speed = 200
		if Input.is_action_just_pressed("A"):
			if $RayCast2D.is_colliding():
				if collider is StaticBody2D: #Chest or Npc: this doesn't work
					collider.main_func() #launch main func in collider
					print(collider)
	else:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
# Game Menu function
	if Input.is_action_just_pressed("Start") and Global.is_paused == false:
		Global.player_xy = position
		$Menu.game_menu() # main func from menu.gd

func ray_dir():
	var dir = Global.raycast_direction
	if dir.x > 0:
		return "right"
	elif dir.x < 0:
		return "left"
	elif dir.y > 0:
		return "down"
	elif dir.y < 0:
		return "up"

func reload_sprite() -> void:
	var res = load("res://data/chars/"+Global.active_party[0]+".tres")
	print("func reload_sprite active")
	$Sprite2D.texture = res.ow_sprite
	pass

func _physics_process(_delta):
	get_input()
	move_and_slide()
	#showing the questionmark sprite when player is in front of an interactable object
	collider = $RayCast2D.get_collider()
	if $RayCast2D.is_colliding():
		if collider.is_in_group("MapObject"):
			$AttentionMark.show()
		else:
			$AttentionMark.hide()
	else:
		$AttentionMark.hide()
