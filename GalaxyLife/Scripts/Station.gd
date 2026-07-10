# ==================================================
# SCRIPT: Station.gd
# Описание: Космическая станция
# Версия: 0.1
# ==================================================
extends Node2D
# =====================
# ДАННЫЕ СТАНЦИИ
# =====================
var station_name = "Станция Альфа"
var population = 1000
var has_market = true
# =====================
# РЕСУРСЫ СТАНЦИИ
# =====================
var storage = {
	"metal": 0,
	"energy": 0
}
# =====================
# СИСТЕМА ЗАДАНИЙ СТАНЦИИ
# =====================
var missions = [
	{
		"name":"Поиск ресурсов",
		"reward":300,
		"target":"asteroid"
	}
]
# =====================
# СОЗДАНИЕ СТАНЦИИ
# =====================
func _ready():
	print("Станция создана:", station_name)
	print("Население:", population)
	print("Склад:", storage)
	var world = get_parent()
	world.stations.append(self)
# =====================
# ПОЛУЧЕНИЕ РЕСУРСОВ
# =====================
func add_resource(type, amount):
	if storage.has(type):
		storage[type] += amount
	else:
		storage[type] = amount
	print(
		station_name,
		" получила ",
		amount,
		type
	)
	print("Склад:", storage)
#Тут конец название скрипта Station
