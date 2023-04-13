extends CharacterBody2D

@export var walk_speed = 4.0
const TILE_SIZE = 32

@onready var ray = $RayCast2D

var initial_position = Vector2(0, 0,)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0.0

#Called when the node enters in the scene tree the first time
func _ready():
	initial_position = position


func _physics_process(delta):
	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false

func process_player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if input_direction != Vector2.ZERO:
		initial_position = position
		is_moving = true

func move(delta):
	var desired_step: Vector2 = input_direction * TILE_SIZE / 2
	ray.cast_to = desired_step
	ray.force_raycast_update()
	if !ray.is_colliding():
		percent_moved_to_next_tile += walk_speed * delta
		if percent_moved_to_next_tile >= 1.0:
			position = initial_position + (TILE_SIZE * input_direction)
			percent_moved_to_next_tile = 0.0
			is_moving = false
		else:
			position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)
	else:
		is_moving = false
