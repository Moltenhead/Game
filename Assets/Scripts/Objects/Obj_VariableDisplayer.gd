extends Label

onready var IDisplay = $IVariableDisplay

export(int, "Inputs") var source_id = 0
export(String) var variable_name = ""

var variable_value
var true_string = ""
var source_target

func _set_source():
	match source_id:
		0:
			source_target = InputMap

func update_value():
	match source_id:
		0:
			variable_value = source_target.get_action_list(variable_name)[-1]

func _update_data():
	_set_source()
	update_value()

func update_text():
	true_string = RawArray([variable_value.unicode]).get_string_from_ascii()
	print(true_string)
	set_text(true_string)

func _on_ready():
	_update_data()
	update_text()

func _ready():
	_on_ready()
