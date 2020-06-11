extends VBoxContainer

export(NodePath) var initial_focus = null

func _on_ready():
	if initial_focus != null:
		get_node(initial_focus).grab_focus()
	else:
		print("Missing initial focus.")

func _ready():
	_on_ready()

# controls
func _process(delta):
	pass
