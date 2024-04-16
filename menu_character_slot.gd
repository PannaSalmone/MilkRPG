extends HBoxContainer

signal swap(name)
var is_active = false
var charname = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_active == true:
		if Input.is_action_just_pressed("A"):
			emit_signal("swap", charname)
			

func set_slot_data(Resource) -> void:
	$Portrait.texture = Resource.portrait
	$Name.text = Resource.name
	charname = Resource.name
	$HP.text = "HP: " + str(Resource.HP)

func _on_focus_entered() -> void:
	$">".show()
	is_active = true
	
func _on_focus_exited() -> void:
	$">".hide()
	is_active = false

