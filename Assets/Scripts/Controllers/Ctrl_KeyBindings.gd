extends Node

const EditableKeys = [
	"ui_left",
	"ui_right",
	"ui_up",
	"ui_down"
]

var _default_keys = {
	'ui_accept': KEY_E,
	'ui_left': KEY_A,
	'ui_right': KEY_D,
	'ui_up': KEY_W,
	'ui_down': KEY_S
}
var _actual_keys = _default_keys

func _change_key(action_str, new_key):
	InputMap.action_erase_event(action_str, _actual_keys[action_str])
	InputMap.action_add_event(action_str, new_key)
	
	_actual_keys[action_str] = new_key
func _set_actual_true_keys():
	for action_str in EditableKeys:
		_actual_keys[action_str] = InputMap.get_action_list(action_str)[-1]
func _set_default_keys():
	for action_str in _default_keys.keys():
		_change_key(action_str, _default_keys[action_str])

func request_key_change(action_str, target_key):
	if !EditableKeys.has(action_str):
		print("Action is not editable")
		return
	elif target_key.get_type() == InputEvent:
		print("target_key is not an InputEvent")
		return
	
	_change_key(action_str, target_key)

func _on_ready():
	_set_actual_true_keys()

func _ready():
	_on_ready()
