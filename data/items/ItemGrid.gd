extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func desc_update(desc):
	%Description.text = desc

func focus_on_use():
	$"../../ButtonPanel/use".grab_focus()
	
