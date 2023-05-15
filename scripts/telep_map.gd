extends Area2D

@export var mapindex: int = 0
@export var warp_to := Vector2.ZERO

var mapname = Global.IDmap

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	Global.player_spawn_point = warp_to
	print("warp to ", mapname[mapindex], " at ", warp_to) 
	get_tree().change_scene_to_file("res://"+ (mapname[mapindex]) +".tscn")
