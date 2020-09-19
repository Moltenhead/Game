extends Node

const QueueScript = preload("res://Assets/Scripts/Controllers/Ctrl_ResourceQueue.gd")
var queue

const BaseScenePath = "res://Assets/Scenes/DisplayScenes/MainMenu/MainMenu.tscn"

const MainLoadingScene = preload("res://Assets/Scenes/DisplayScenes/Loading/BaseLoadingScreen.tscn")
const SubLoadingScene = preload("res://Assets/Scenes/DisplayScenes/Loading/BaseLoadingScreen.tscn")

onready var LoadingScreenWrapper = $LoadingScreenWrapper
onready var CurrentSceneWrapper = $CurrentSceneWrapper

var loader
var target_scene_path
var last_target_scene_path
var wait_frames
var time_max = 100 # msec
var current_scene
var current_loading_screen_type
onready var current_loading_screen = MainLoadingScene

func goto_scene(path): # game requests to switch to this scene
	if path == null:
		print("Missing a path argument")
		return
	
	LoadingScreenWrapper.set_visible(true)
	CurrentSceneWrapper.set_visible(false)
	target_scene_path = path
	var scene = queue.get_resource(target_scene_path)
	if scene == null:
		queue.queue_resource(target_scene_path)
		set_process(true)
		wait_frames = 1
	else:
		for node in CurrentSceneWrapper.get_children():
			node.queue_free()
		set_new_scene(scene)

func update_progress():
	var progress = queue.get_progress(target_scene_path)
	current_loading_screen.set_progress(progress)

func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	last_target_scene_path = target_scene_path
	target_scene_path = null
	CurrentSceneWrapper.add_child(current_scene)
	CurrentSceneWrapper.set_visible(true)
	LoadingScreenWrapper.set_visible(false)

func set_loading_screen_type(type):
	if type == current_loading_screen_type:
		print("Loading Screen type is already set to '" + str(type) + "'")
		return

	current_loading_screen_type = type
	match type:
		"main":
			current_loading_screen = MainLoadingScene.instance()
		"sub":
			current_loading_screen = SubLoadingScene.instance()

	for node in LoadingScreenWrapper.get_children():
		node.queue_free()
	LoadingScreenWrapper.add_child(current_loading_screen)

func _ready():
	queue = QueueScript.new()
	queue.start()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	set_loading_screen_type("main")
	LoadingScreenWrapper.set_visible(true)
	CurrentSceneWrapper.set_visible(false)
	
	goto_scene(BaseScenePath)

func _process(time):
	if loader == null:
	    # no need to process anymore
	    set_process(false)
	    return
	
	if wait_frames > 0: # wait for frames to let the "loading" animation show up
	    wait_frames -= 1
	    return
	
	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control for how long we block this thread
	
	    # poll your loader
	    var err = loader.poll()
	
	    if err == ERR_FILE_EOF: # Finished loading.
	        var resource = loader.get_resource()
	        loader = null
	        set_new_scene(resource)
	        break
	    elif err == OK:
	        update_progress()
	    else: # error during loading
	        print("Error during loading.")
	        loader = null
	        break
