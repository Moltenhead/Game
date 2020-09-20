tool
extends Button

export(String) var string_id = ""
export(int, "validation", "setting", "out", "quit") var type = 0

var actual_string_id = string_id
var true_string = ""
var navigation_menu = null
onready var action = $Action

func _pressed():
	if action == null :
		print("There is no action to call.")
		return
	elif !action.has_method("_execute"):
		print("There is no _execute() methode to call for action " + str(action) + ".")
		return
	
	action._execute()

func update_text():
	true_string = tr(string_id).to_upper()
	set_text(true_string)
	actual_string_id = string_id

func _on_ready():
	navigation_menu = get_parent()
	if action == null: action = $Action
	if string_id == "" || string_id == null: return
	update_text()

func _ready():
	_on_ready()

func _process(delta):
	if Engine.editor_hint:
		if actual_string_id != string_id:
			update_text()
