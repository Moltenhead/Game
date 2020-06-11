tool
extends Node

onready var Ui = $Ui
onready var Char = $Char
onready var UiMain = $Ui/UiMain

onready var last_depth_parents = [UiMain, Char]
var existing_players_names = []

func _ready():
	for node in last_depth_parents:
		for sub_node in node.get_children():
			if sub_node is AudioStreamPlayer:
				existing_players_names.append(sub_node.name)

func play_ui_main(player_name):
	if existing_players_names.has(player_name):
		UiMain.get_node(player_name).play()
	else:
		print("Player '" + player_name + "' not found.")
