# ============================================================
# БЛОК 1: НАСЛЕДОВАНИЕ
# ============================================================
extends Node2D

# ============================================================
# БЛОК 2: ПЕРЕМЕННЫЕ (меняй здесь)
# ============================================================
var amount = 1000
var depleted = false
var max_amount = 1000
var size_type = "med"  # small, med, large

# ============================================================
# БЛОК 3: СПРАЙТЫ (пути к твоим файлам .jpg)
# ============================================================
@onready var sprite = $Sprite2D

# Загружаем текстуры из папки Assets/Sprites/Asteroids/
var small_texture = preload("res://GalaxyLife/Assets/Sprites/Asteroids/asteroid_small.jpg")
var med_texture = preload("res://GalaxyLife/Assets/Sprites/Asteroids/asteroid_med.jpg")
var large_texture = preload("res://GalaxyLife/Assets/Sprites/Asteroids/asteroid_large.jpg")

# ============================================================
# БЛОК 4: СОЗДАНИЕ
# ============================================================
func _ready():
	max_amount = amount
	# Выбираем спрайт в зависимости от размера
	match size_type:
		"small":
			sprite.texture = small_texture
			sprite.scale = Vector2(0.8, 0.8)
		"med":
			sprite.texture = med_texture
			sprite.scale = Vector2(1.0, 1.0)
		"large":
			sprite.texture = large_texture
			sprite.scale = Vector2(1.2, 1.2)
	print("💎 Астероид (", size_type, "): ", amount)

# ============================================================
# БЛОК 5: ЛОГИКА
# ============================================================
func mine(value):
	if depleted:
		print("⚠️ Астероид пуст")
		return 0
	
	var mined = min(value, amount)
	amount -= mined
	
	if amount <= 0:
		amount = 0
		depleted = true
		# Меняем цвет на серый (пустой)
		sprite.modulate = Color(0.5, 0.5, 0.5)
		print("💥 Астероид полностью добыт!")
	
	print("⛏️ Добыто: ", mined, " (осталось: ", amount, ")")
	return mined
