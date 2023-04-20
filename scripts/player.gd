extends CharacterBody2D

@export var speed = 300
var culo = false

func _on_body_entered(body):	 
	culo = true

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	if culo == true:
		if Input.is_action_just_pressed("ui_accept"):
			print("culo")
	get_input()
	move_and_slide()



