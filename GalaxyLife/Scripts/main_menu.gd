extends Control


func _on_new_game_button_pressed():
	GameManager.new_game()
	get_tree().change_scene_to_file("res://GalaxyLife/Scenes/World.tscn")
