extends Node

export(String) var targeted_action = ""

func _execute():
	KeyBindings.key_input(targeted_action)
