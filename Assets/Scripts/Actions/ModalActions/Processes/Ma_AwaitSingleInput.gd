extends Node

export(Array, InputEvent) 	var key_restrictions
export(Script) 				var applied_action_script

var _applied_action
var _has_restrictions

func _ready():
	_applied_action = applied_action_script.new()
	_has_restrictions = true if key_restrictions.size > 0 else false

func _apply(modal, input):
	_applied_action._execute(modal, input)

func _execute(modal):
	if (
		modal.active &&
		event is InputEventKey &&
		event.pressed &&
		(
			(_has_restrictions && key_restrictions.has(event.scancode)) ||
			!_has_restrictions
		)
	):
		_apply(modal, event.scancode)
