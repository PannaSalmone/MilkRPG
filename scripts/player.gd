extends CharacterBody2D

@export var speed: int = 300
@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
var is_moving = false

func _ready():
	$RayCast2D.target_position = Global.raycast_direction #Globalized Raycast2d target
	position = Global.player_xy #Position set in global script and updated with warp script
	anim_tree.set("parameters/Idle/blend_position" , $RayCast2D.target_position)
	
func get_input():
	if Global.playerispaused == false:
		var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if input_direction != Vector2.ZERO:
			$RayCast2D.target_position = input_direction * 28 #32 raycast lenght
			Global.raycast_direction = $RayCast2D.target_position #Raycast direction going global
			anim_tree.set("parameters/Idle/blend_position" , input_direction)
			anim_tree.set("parameters/Walk/blend_position" , input_direction)
			anim_state.travel("Walk")
			input_direction = input_direction.normalized()
			velocity = input_direction * speed
			is_moving = true
		else:
			anim_state.travel("Idle")
			velocity = Vector2.ZERO
			is_moving = false

# Event checking + event scripts
		if Input.is_action_just_pressed("ui_accept"):
			if $RayCast2D.is_colliding():
				var collider = $RayCast2D.get_collider()
				if collider is StaticBody2D: #Chest or Npc: this doesn't work
					collider.main_func() #launch main func in collider 
					var text: String = collider.texto
					$TextBox.dialogue_box(text)
					print(text)
					print(collider)

# Game Menu function
	if Input.is_action_just_pressed("ui_select"):
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


func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
	
