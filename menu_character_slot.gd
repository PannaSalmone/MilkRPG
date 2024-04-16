extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_slot_data(Resource) -> void:
	$Portrait.texture = Resource.portrait
	$Name.text = Resource.name
	$HP.text = "HP: " + str(Resource.HP)



func _on_focus_entered() -> void:
	$">".show()

func _on_focus_exited() -> void:
	$">".hide()

