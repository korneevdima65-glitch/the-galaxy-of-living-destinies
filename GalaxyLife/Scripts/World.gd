# ============================================================
# БЛОК 1: НАСЛЕДОВАНИЕ
# ============================================================
extends Node2D

# ============================================================
# БЛОК 2: ПЕРЕМЕННЫЕ (меняй здесь)
# ============================================================
@export var asteroid_count = 15
@export var npc_count = 3
@export var world_size = 2000

# Списки объектов
var asteroids = []
var npcs = []
var stations = []

# ============================================================
# БЛОК 3: ССЫЛКИ НА СЦЕНЫ (проверь пути!)
# ============================================================
var asteroid_scene = preload("res://GalaxyLife/Scenes/Asteroid.tscn")
var npc_scene = preload("res://GalaxyLife/Scenes/NPCShip.tscn")
var station_scene = preload("res://GalaxyLife/Scenes/Station.tscn")
var player_scene = preload("res://GalaxyLife/Scenes/PlayerShip.tscn")

# ============================================================
# БЛОК 4: ГЕНЕРАЦИЯ МИРА
# ============================================================
func _ready():
	print("🌌 Генерация мира...")
	generate_world()
	print("✅ Мир готов!")

# ============================================================
# БЛОК 4: ГЕНЕРАЦИЯ МИРА (правильный порядок)
# ============================================================
func generate_world():
	asteroids.clear()
	npcs.clear()
	stations.clear()
	
	# 1. Создаём станцию
	var station = station_scene.instantiate()
	add_child(station)
	station.global_position = Vector2(0, -300)
	stations.append(station)
	print("🏭 Станция создана")
	
	# 2. Создаём астероиды с разными размерами и количеством
	var sizes = ["small", "med", "large"]
	for i in range(asteroid_count):
		var asteroid = asteroid_scene.instantiate()
		# *** ВАЖНО: Устанавливаем свойства ДО добавления в дерево ***
		asteroid.amount = randi_range(500, 3000)
		asteroid.size_type = sizes[randi() % sizes.size()]
		# Теперь добавляем
		add_child(asteroid)
		asteroid.global_position = Vector2(
			randf_range(-world_size, world_size),
			randf_range(-world_size, world_size)
		)
		asteroids.append(asteroid)
		print("   💎 Астероид #", i+1, ": ", asteroid.size_type, " (", asteroid.amount, ")")
		
	# 3. Создаём NPC
	var npc_names = ["Арис", "Кира", "Зорг", "Люсия"]
	for i in range(npc_count):
		var npc = npc_scene.instantiate()
		add_child(npc)
		npc.global_position = Vector2(
			randf_range(-world_size, world_size),
			randf_range(-world_size, world_size)
		)
		npc.npc_name = npc_names[i % npc_names.size()]
		npc.world = self
		npcs.append(npc)
		print("👤 NPC: ", npc.npc_name)
	
	# 4. Создаём игрока в центре
	var player = player_scene.instantiate()
	add_child(player)
	player.global_position = Vector2(0, 0)
	print("🛸 Игрок появился")

# ============================================================
# БЛОК 5: ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
# ============================================================
func get_nearest_asteroid(target_pos):
	var nearest = null
	var min_dist = 999999
	for asteroid in asteroids:
		if not asteroid.depleted:
			var dist = target_pos.distance_to(asteroid.global_position)
			if dist < min_dist:
				min_dist = dist
				nearest = asteroid
	return nearest
func get_nearest_station(target_pos):
	var nearest = null
	var min_dist = 999999
	for station in stations:
		var dist = target_pos.distance_to(station.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest = station
		return nearest
