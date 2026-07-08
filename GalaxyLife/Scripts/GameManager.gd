extends Node


# Данные игрока
var player_name = ""
var player_level = 1
var player_exp = 0
var player_money = 100
var inventory = []


# Корабль игрока
var ship_name = "Старый разведчик"


# Время игры
var game_day = 1
var game_hour = 8


# Начать новую игру
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
	
