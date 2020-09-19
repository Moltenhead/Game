extends Node

export(PackedScene) var FirstScene

# Called when the node enters the scene tree for the first time.
func _ready():
	if !FirstScene:
		print("No FirstScene. Will close ...")
		get_tree().quit()
	else :
		var firstScenePath = FirstScene.resource_path
		SceneManager.goto_scene(firstScenePath)

func _process(delta):
	pass
