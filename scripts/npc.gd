extends StaticBody2D
class_name Npc

@onready var animation = get_node("AnimatedSprite2D")
var text_box = load("res://scenes/menu/text_box.tscn")
@export var dialogue: Resource
@export_enum("right", "left", "down", "up") var direction: String #select the direction of NPC
@export var is_turnable := true
const obj_type := 0

# Called when the node enters the scene tree for the first time.
#future optimization: load npc from map and load JSON only once time
func _ready():
	update_animation(direction) #Change direction of static NPC (idle anim)
	#$culo.texture = dialogue.portrait

#called by Player.gd
func main_func() -> void:
	var box = text_box.instantiate()
	add_child(box)
	box.npc()
	if is_turnable == true:
		$AnimatedSprite2D.play("idle_" + ray_dir())

func update_animation(_dir) -> void:
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
