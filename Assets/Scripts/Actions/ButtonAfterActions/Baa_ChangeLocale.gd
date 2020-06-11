extends Node

func _execute(metadata):
	var actual_locale = TranslationServer.get_locale()
	if !TranslationServer.get_loaded_locales().has(metadata):
		print("The locale " + actual_locale + " is not loaded")
		return "locale_no_changed"
	elif metadata == actual_locale: 
		print("This locale is already active.")
		return "locale_no_changed"
	else:
		TranslationServer.set_locale(metadata)
		print("Locale is now : " + TranslationServer.get_locale())
		return "locale_changed"
