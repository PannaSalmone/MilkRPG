extends Area2D

@export var mapname = "test_area"
@export var warp_to := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(_body):
	print("warp to ", mapname, " at ", warp_to) 
	Global.player_map_location = mapname
	Global.player_xy = warp_to
	get_tree().change_scene_to_file.call_deferred("res://maps/"+ (mapname) +".tscn")
