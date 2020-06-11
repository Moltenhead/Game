extends Node

func _execute(target = self):
	target.get_tree().change_scene("res://Assets/Scenes/DisplayScenes/MainMenu/MainMenu.tscn")
