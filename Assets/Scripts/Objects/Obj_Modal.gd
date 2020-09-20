extends CenterContainer

onready var hop_in		= $HopIn
onready var process 	= $Process
onready var on_input 	= $OnInput
onready var hop_out		= $HopOut
onready var popup 		= $Popup
onready var label		= $Popup/Label

export(bool) var _active = false

var param

func _hop_in():
	if hop_in.get_script() == null:
		return
	hop_in._execute(self)
func _hop_out():
	if hop_out.get_script() == null:
		return
	hop_out._execute(self)

func activate(given_param = null):
	popup.update()
	param = given_param
	_active = true
	_hop_in()
func deactivate():
	_active = false
	_hop_out()
func toggle():
	if _active:
		_hop_out()
	else:
		_hop_in()
	_active = !_active

func set_popup_text(string):
	label.set_text(string)

func _on_ready():
	activate() if _active else deactivate()
	if process.get_script() == null:
		set_process(false)
func _ready():
	_on_ready()

func _input(event):
	if !_active || on_input.get_script() == null:
		return
	
	on_input._execute(self, event, param)

func _process(delta):
	if !_active || process.get_script() == null:
		return

	process._execute(self)
