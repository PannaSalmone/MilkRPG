extends Area2D

@export var warp_loc= Vector2.ZERO
var into = false

func _on_Warp_body_entered(body):
	into = true 
	print("culo")
#if Input.is_action_just_pressed("ui_accept"):
#		body.position = warp_loc
		
#func _on_body_exited(body : PhysicsBody2D):
#	into = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if into == true:
		if Input.is_action_just_pressed("ui_accept"):
			print("culo")
		#global_position = warp_loc






