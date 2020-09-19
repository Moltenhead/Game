extends "res://Assets/Scripts/Objects/Obj_NavigationMenu.gd"
const OptionSelector = preload("res://Assets/Scripts/Objects/Obj_OptionSelector.gd")
const OptionSelector_OptionsList = preload("res://Assets/Scripts/Objects/Obj_OptionSelector_OptionsList.gd")

onready var EscapeAction = $EscapeAction

var has_escape_action
var escape_action
var already_moved = false

func _play_navigation_sound(node = null):
	if !already_moved:
		already_moved = true
	else:
		AudioManager.play_ui_main("Move")

func _play_sub_navigation_sound(index):
	AudioManager.play_ui_main("SubMove")

func _play_validate_sound(node = null):
	if node == null:
		AudioManager.play_ui_main("Validate")
	else:
		match node.type:
			0:
				AudioManager.play_ui_main("Validate")
			2:
				AudioManager.play_ui_main("Out")
			3:
				AudioManager.play_ui_main("Quit")

func _button_assoc_sound(button):
	button.connect("focus_entered", self, "_play_navigation_sound", [button])
	button.connect("button_down", self, "_play_validate_sound", [button])

func _on_ready():
	var _self = self
	has_escape_action = true if EscapeAction && EscapeAction.get_script() != null else false
	for node in get_children():
		if node is Button:
			_button_assoc_sound(node)
		if node is OptionSelector:
			for sub_node in node.get_children():
				if sub_node is OptionSelector_OptionsList:
					sub_node.connect("focus_entered", _self, "_play_navigation_sound")
					sub_node.connect("item_selected", _self, "_play_sub_navigation_sound")
				elif sub_node is Button:
					_button_assoc_sound(sub_node)
	._on_ready()

func _ready():
	_on_ready()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") && has_escape_action:
		EscapeAction._execute()
