extends CharacterBody2D

@export var speed = 300

func _ready():
	position = Global.player_spawn_point

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()



