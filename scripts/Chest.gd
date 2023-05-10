extends StaticBody2D
class_name Chest

@export var item = "sword"
var is_closed = true

#called by Player.gd
func main_func():
	if is_closed == true:
		print("u found ", item)
		$ChestClosed.visible = false
		$ChestOpened.visible = true
		is_closed = false
	else:
		print("IT IS EMPTY")
