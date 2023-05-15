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
	print(Npc_name,": ", Npc_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_animation(dir):
	animation.play("idle_" + direction)
	
