extends Node

export(Array, InputEvent) 	var key_restrictions = []

var _has_restrictions

func _ready():
	_has_restrictions = true if key_restrictions.size() > 0 else false

func _execute(modal, event, param):
	if !(event is InputEventKey):
		return
	if (
		!event.pressed || _has_restrictions &&
		!key_restrictions.has(event.scancode)
	):
		return
	KeyBindings.request_key_change(param, event)
	modal.deactivate()
