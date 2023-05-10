extends StaticBody2D
class_name Npc

#@export_file("*.png") var sprite
@export var Npc_text = ""
@export var Npc_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	#var loadsprite = load(sprite)
	#$AnimatedSprite2D.sprite_frames = loadsprite
	pass
#called by Player.gd
func main_func():
	print(Npc_name,": ", Npc_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
