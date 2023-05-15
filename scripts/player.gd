extends CharacterBody2D

@export var speed: int = 300
@onready var animation = get_node("AnimatedSprite2D")

func _ready():
	$RayCast2D.target_position = Global.raycast_direction #Globalized Raycast2d target
	position = Global.player_spawn_point #Position set in global script and updated with warp script

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction = input_direction.normalized()
	velocity = input_direction * speed
	
	if input_direction != Vector2.ZERO:
		$RayCast2D.target_position = input_direction * 32 #32 raycast lenght
		Global.raycast_direction = $RayCast2D.target_position #Raycast direction going global
		update_animation(input_direction)
	else:
		$AnimatedSprite2D.play("idle_" + ray_dir())
# Event checking
	if Input.is_action_just_pressed("ui_accept"):
		if $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider is Chest || Npc:
				collider.main_func()
	
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
	
func update_animation(input_direction):
	if input_direction.x > 0:
		animation.flip_h = true #flip walk_right animation cuz there is no proper sprite for right idle and walk animation
		animation.play("walk_right")
	elif input_direction.x < 0:
		animation.flip_h = false
		animation.play("walk_left")
	elif input_direction.y > 0:
		animation.play("walk_down")
	elif input_direction.y < 0:
		animation.play("walk_up")
