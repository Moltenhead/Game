extends Node

export(String, FILE, "*.tscn,*.scn") var scene_target = null

func _execute():
	SceneManager.goto_scene(scene_target)
