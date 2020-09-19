extends Node

export(PackedScene) var FirstScene = null

func _ready():
	if !FirstScene:
		print("Missing FirstScene.")
	else:
		SceneManager.goto_scene(FirstScene)
