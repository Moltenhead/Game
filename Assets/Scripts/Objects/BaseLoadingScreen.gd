extends Control

onready var textureProgress = $ColorRect/CenterContainer/VBoxContainer/TextureProgress

func update_progress(progress: float) -> void:
	textureProgress.set_value(progress)
