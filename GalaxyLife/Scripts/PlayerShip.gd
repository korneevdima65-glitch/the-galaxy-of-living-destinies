# ============================================================
# БЛОК 1: НАСЛЕДОВАНИЕ
# ============================================================
extends CharacterBody2D

# ============================================================
# БЛОК 2: ПЕРЕМЕННЫЕ
# ============================================================
var speed = 400
var health = 100
var energy = 100
var is_alive = true

# ============================================================
# БЛОК 3: СЦЕНЫ
# ============================================================
var wreck_scene = preload("res://GalaxyLife/Scenes/Wreck.tscn")

# ============================================================
# БЛОК 4: УПРАВЛЕНИЕ (ВСЕ КЛАВИШИ ЧЕРЕЗ Input.)
# ============================================================
func _process(delta):
	if not is_alive:
		return
	
	# Движение (используем Input Actions)
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):    direction.y -= 1
	if Input.is_action_pressed("move_down"):  direction.y += 1
	if Input.is_action_pressed("move_left"):  direction.x -= 1
	if Input.is_action_pressed("move_right"): direction.x += 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		rotation = velocity.angle()
		energy -= delta * 1.5
		if energy <= 0:
			energy = 0
			print("⚠️ Энергия закончилась!")
	else:
		velocity = Vector2.ZERO
		if energy < 100:
			energy += delta * 0.3
	
	# Обновляем GameManager
	GameManager.player_health = health
	GameManager.player_energy = energy
	
	# Добыча (используем действие "mine")
	if Input.is_action_just_pressed("mine"):
		mine_asteroid()
	
	# Самоуничтожение (действие "destroy")
	if Input.is_action_just_pressed("destroy"):
		destroy_ship()
	
	# Выход (действие "quit")
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

# ============================================================
# БЛОК 5: ЛОГИКА
# ============================================================
func mine_asteroid():
	var world = get_parent()
	if world and world.has_method("get_nearest_asteroid"):
		var asteroid = world.get_nearest_asteroid(global_position)
		if asteroid and global_position.distance_to(asteroid.global_position) < 100:
			var mined = asteroid.mine(10)
			if mined > 0:
				GameManager.add_money(mined * 2)
				print("⛏️ Добыто: ", mined, " металла (+", mined*2, " кредитов)")
			return
	print("🔍 Рядом нет астероидов")

func destroy_ship():
	if not is_alive:
		return
	is_alive = false
	print("💀 Корабль уничтожен!")
	
	var wreck = wreck_scene.instantiate()
	get_parent().add_child(wreck)
	wreck.global_position = global_position
	wreck.setup([])
	
	queue_free()
