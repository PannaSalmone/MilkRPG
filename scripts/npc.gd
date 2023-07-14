extends StaticBody2D
class_name Npc

@onready var animation = get_node("AnimatedSprite2D")

@export_enum("right", "left", "down", "up") var direction: String #select the direction of NPC
@export var dialogue := ""
@export var objname := ""
var texto: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():	
	update_animation(direction) #Change direction of static NPC (idle anim)	
	pass

#called by Player.gd
func main_func():
	texto = str(objname + ": " + dialogue)
	$AnimatedSprite2D.play("idle_" + ray_dir())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_animation(_dir):
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
	



