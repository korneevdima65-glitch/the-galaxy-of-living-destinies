# ==================================================
# SCRIPT: GameManager.gd
# Описание: Главный менеджер данных игры
# Версия: 0.1
# ==================================================
extends Node
# =====================
# ДАННЫЕ ИГРОКА
# =====================
var player_name = ""
var player_level = 1
var player_exp = 0
var player_money = 100
var inventory = []

# =====================
# КОРАБЛЬ ИГРОКА
# =====================
var ship_name = "Старый разведчик"
# =====================
# ВРЕМЯ ИГРЫ
# =====================
var game_day = 1
var game_hour = 8

# =====================
# НОВАЯ ИГРА
# =====================
func new_game():
	player_name = "Новый пилот"
	player_level = 1
	player_exp = 0
	player_money = 100
	inventory.clear()
	inventory.append({
	"name": "Старый лазер",
	"type": "weapon",
	"value": 100
})
	inventory.append({
	"name": "Ремкомплект",
	"type": "repair",
	"value": 50
})
	ship_name = "Старый разведчик"
	game_day = 1
	game_hour = 8
	print("Новая игра создана")
	
#Тут конец название скрипта GameManager
