extends Node

var modal_skeleton_text = tr("KEYBINDREQ")
var modal_interpolated_text

onready var modal = $Modal

const _editableKeys = [
	"ui_left",
	"ui_right",
	"ui_up",
	"ui_down"
]
const _ui_to_code = {
	"ui_left"	: "KEYLFT",
	"ui_right"	: "KEYRGT",
	"ui_up"		: "KEYUP",
	"ui_down"	: "KEYDWN"
}

var _default_keys = {
	'ui_accept'	: KEY_E,
	'ui_left'	: KEY_A,
	'ui_right'	: KEY_D,
	'ui_up'		: KEY_W,
	'ui_down'	: KEY_S
}
var _actual_keys = _default_keys

func _interpolate_modal_text(replacer):
	modal_interpolated_text = modal_skeleton_text % replacer

func key_input(action_name):
	_interpolate_modal_text(_ui_to_code[action_name])
	modal.set_popup_text(modal_interpolated_text)
	modal.activate(action_name)

func _change_key(action_str, new_key):
	InputMap.action_erase_event(action_str, _actual_keys[action_str])
	InputMap.action_add_event(action_str, new_key)
	
	_actual_keys[action_str] = new_key
func _set_actual_true_keys():
	for action_str in _editableKeys:
		_actual_keys[action_str] = InputMap.get_action_list(action_str)[-1]
func _set_default_keys():
	for action_str in _default_keys.keys():
		_change_key(action_str, _default_keys[action_str])

func request_key_change(action_str, target_key):
	if !_editableKeys.has(action_str):
		print("Action is not editable")
		return
	elif !(target_key is InputEventKey):
		print("target_key is not an InputEventKey")
		return
	
	_change_key(action_str, target_key)

func _on_ready():
	_set_actual_true_keys()

func _ready():
	_on_ready()
