extends MarginContainer

export(Script) var action_script = null

var action = null

func _ready():
	action = action_script.new() if action_script != null else null

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		action._execute(self)
