extends MapObject

@onready var animation = get_node("AnimatedSprite2D")
@export var dialogue_res: Resource
@export_enum("right", "left", "down", "up") var direction: String #NPC spawn direction
@export var is_turnable := true #npc turns toward player while talking
@export var spin := false

#const obj_type := 0

# Called when the node enters the scene tree for the first time.
#future optimization: load npc from map and load JSON only once time
func _ready():
	update_animation() #Change direction of static NPC (idle anim)

#called by Player.gd
func main_func() -> void:
	var text_box = load("res://scenes/menu/text_box.tscn")
	var box = text_box.instantiate()
	add_child(box)
	box.npc(dialogue_res)
	if is_turnable == true:
		$AnimatedSprite2D.play("idle_" + ray_dir())
		$Timer.start()

func update_animation() -> void:
	if spin == true:
		$Timer.start()
	else:
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

func _on_timer_timeout() -> void:
	if Global.is_paused == false:
		if spin == true:
			var random_num = randi() % 4
			match random_num:
				0: animation.play("idle_" + "up")
				1: animation.play("idle_" + "down")
				2: animation.play("idle_" + "left")
				3: animation.play("idle_" + "right")
		else:
			animation.play("idle_" + direction)
