extends Node2D
class_name Battler

var speed := 1
var NAME := ""
var is_active = false
signal change_state(state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func take_data(res) -> void:
	$CharSprite.texture = res.battle_sprite
	speed = res.SPE
	NAME = res.name

func is_selected() -> void:
	if is_active == false:
		position.x -= 40
		is_active = true
		emit_signal("change_state", 1)
	else:
		is_active = false
		position.x += 40
