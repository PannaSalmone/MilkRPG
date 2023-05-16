extends StaticBody2D
class_name Npc

@onready var animation = get_node("AnimatedSprite2D")

@export_enum("right", "left", "down", "up") var direction: String #select the direction of NPC
@export var Npc_text = ""
@export var Npc_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	update_animation(direction) #Change direction of static NPC (idle anim)
	pass
	
	
#called by Player.gd
func main_func():
	$AnimatedSprite2D.play("idle_" + ray_dir())
	print(Npc_name,": ", Npc_text)
	print(Global.raycast_direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_animation(dir):
	animation.play("idle_" + direction)

func ray_dir():
	var dir = Global.raycast_direction
	if dir.x > 0:
		return "left"
	elif dir.x < 0:
		return "right"
	elif dir.y > 0:
		return "up"
	elif dir.y < 0:
		return "down"
	
