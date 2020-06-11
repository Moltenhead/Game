extends Node

func _execute():
	print("Trying to exit the game ..." + str(get_tree()))
	get_parent().get_tree().quit()
