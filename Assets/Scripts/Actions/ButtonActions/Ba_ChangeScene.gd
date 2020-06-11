extends Node

export(PackedScene) var scene_target = null

func _execute():
	get_tree().change_scene_to(scene_target)
