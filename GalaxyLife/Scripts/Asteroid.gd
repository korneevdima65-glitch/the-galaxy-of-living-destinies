# ==================================================
# SCRIPT: Asteroid.gd
# Описание: Астероид с ресурсами
# Версия: 0.1
# ==================================================
extends Node2D
# =====================
# ДАННЫЕ АСТЕРОИДА
# =====================

var resource_type = "metal" # Тип астероида
var amount = 1000 # Запас ресурса
var asteroid_size = "medium" # Размер астероида
var depleted = false # Был ли полностью добыт

# =====================
# СОЗДАНИЕ ОБЪЕКТА
# =====================
func _ready():
	print("Астероид появился")
	var world = get_parent()
	world.asteroids.append(self)
# =====================
# ДОБЫЧА РЕСУРСА
# =====================
func mine(value):
	if depleted:
		print("Астероид пуст")
		return
	amount -= value
	if amount <= 0:
		amount = 0
		depleted = true
		print("Астероид полностью добыт")
	print(
		"Добыто:",
		resource_type,
		value
	)
	print(
		"Осталось:",
		amount
	)
#Тут конец название скрипта Asteroid
