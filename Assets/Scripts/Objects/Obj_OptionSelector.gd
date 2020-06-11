tool
extends HBoxContainer

export(String) var title_id = ""
export(Array, String) var options_labels = []
export(Array, Texture) var options_icons = []
export(Array, String) var options_metas = []

onready var label = $Label
onready var options_list = $OptionsList

var actual_title_id = title_id
var actual_options_labels = options_labels
var actual_options_icons = options_icons

func is_missing_node():
	return label == null || options_list == null

func set_nodes():
	print(str(label) + str(options_list))
	if label == null: label = $Label
	if options_list == null: options_list = $OptionsList

func update_label():
	if label == null: return
	
	label.set_text(tr(title_id))

func update_list():
	if options_list != null: options_list.clear()
	actual_options_labels = options_labels
	actual_options_icons = actual_options_icons
	for i in range(0, options_labels.size()):
		var icon = options_icons[i] if i < options_icons.size() else null
		var meta = options_metas[i] if i < options_metas.size() else null
		options_list.add_item(tr(options_labels[i]), icon)
		options_list.set_item_metadata(i, meta)
		if meta == TranslationServer.get_locale(): options_list.select(i)

func update_display():
	update_label()
	update_list()
	$Button.update_text()

func options_changed():
	if options_labels.size() != actual_options_labels.size() || options_icons.size() != actual_options_icons.size(): return true
	
	for i in range(0, options_labels.size()):
		if options_labels[i] != actual_options_labels[i]: return true
	for i in range(0, options_icons.size()):
		if options_icons[i] != actual_options_labels[i]: return true
	return false

func _ready():
	connect("locale_changed", self, "update_display")
	update_display()

func _process(delta):
	if Engine.editor_hint:
		if is_missing_node(): set_nodes()
		if actual_title_id != title_id: update_label()
		if options_changed():
			update_list()
