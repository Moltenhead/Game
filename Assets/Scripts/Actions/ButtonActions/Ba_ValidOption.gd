extends Node

signal locale_changed

export(Script) var after_validate_action = null

var item_list = null
var selected = null

func _execute():
	var siblings = get_parent().get_parent().get_children()
	for node in siblings:
		if node is ItemList:
			item_list = node
			break
	selected = item_list.get_selected_items()[0]
	if after_validate_action == null:
		print("No after validate action.")
		return
	elif after_validate_action.has_method("_execute"):
		print("After validate action has no _execute() method.")
		return
	
	var action = after_validate_action.new()
	emit_signal(action._execute(item_list.get_item_metadata(selected)))
