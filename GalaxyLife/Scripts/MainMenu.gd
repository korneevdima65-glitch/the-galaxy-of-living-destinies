# ==================================================
# SCRIPT: main_menu.gd
# Описание: Главное меню игры
# Версия: 0.1
# ==================================================
extends Control
# =====================
# СОЗДАНИЕ НОВОЙ ИГРЫ
# =====================
func _on_new_game_button_pressed():
	GameManager.new_game()
	get_tree().change_scene_to_file("res://GalaxyLife/Scenes/World.tscn")

#Тут конец название скрипта main_menu
