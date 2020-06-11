tool
extends Node

export(bool) var inverted_h = false
export(bool) var inverted_v = false

func _execute(navigation_menu):
	var h_direction = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	if inverted_h: h_direction *= -1
	var v_direction = int(Input.is_action_just_pressed("ui_up")) - int(Input.is_action_just_pressed("ui_down"))
	if inverted_v: v_direction *= -1
	
	var validate = Input.is_action_just_pressed("ui_accept")
	
	if v_direction != 0: navigation_menu.move_index_by(v_direction)
	if validate: navigation_menu.trigger_actual_index()
