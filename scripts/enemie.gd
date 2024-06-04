extends Node2D
class_name Enemy

var NAME := ""
var speed :int = 0
var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func take_data(res):
	$Sprite.texture = res.sprite
	speed = res.speed
	NAME = res.name

func is_selected() -> void:
	if is_active == false:
		$Label.show()
		is_active = true
	else:
		is_active = false
		$Label.hide()
		
func attack() -> void:
	pass
