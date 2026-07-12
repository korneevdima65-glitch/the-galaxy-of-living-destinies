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
var mine_cooldown = 0.0
var mine_interval = 0.2
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
	if Input.is_action_pressed("W"):direction.y -= 1
	if Input.is_action_pressed("S"):direction.y += 1
	if Input.is_action_pressed("A"):direction.x -= 1
	if Input.is_action_pressed("D"):direction.x += 1

	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		rotation = velocity.angle()
	else:
		velocity = Vector2.ZERO

	# Автодобыча при зажатой левой кнопке мыши
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mine_cooldown -= delta
		if mine_cooldown <= 0:
			mine_cooldown = mine_interval
			try_mine_at_cursor()

	# Самоуничтожение (действие "destroy")
	if Input.is_action_just_pressed("K"):
		destroy_ship()
	
	if Input.is_action_just_pressed("E"):
		sell_cargo()

	# Выход (действие "quit")
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

	# Обновляем GameManager
	GameManager.player_health = health
	GameManager.player_energy = energy

# ============================================================
# БЛОК 5: ДОБЫЧА
# ============================================================
func try_mine_at_cursor():
	var mouse_pos = get_global_mouse_position()
	var world = get_parent()
	if world and world.has_method("get_nearest_asteroid"):
		var asteroid = world.get_nearest_asteroid(mouse_pos)
		if asteroid:
			var dist = global_position.distance_to(asteroid.global_position)
			if dist < 150:
				var mined = asteroid.mine(10)
				if mined > 0:
					GameManager.add_cargo("metal", mined)
					# Можно выводить сообщение, но реже, чтобы не заспамливать
					# print("⛏️ Добыто: ", mined)
			else:
				# Можно вывести один раз, но не каждый кадр
				pass
				
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Получаем позицию клика в мировых координатах
		var click_pos = get_global_mouse_position()
		var world = get_parent()
		if world and world.has_method("get_nearest_asteroid"):
			var asteroid = world.get_nearest_asteroid(click_pos)
			if asteroid:
				# Проверяем расстояние от КОРАБЛЯ до астероида
				var dist_to_asteroid = global_position.distance_to(asteroid.global_position)
				if dist_to_asteroid < 150:  # дальность добычи 150 пикселей
					var mined = asteroid.mine(10)
					if mined > 0:
						GameManager.add_cargo("metal", mined)
						print("⛏️ Добыто: ", mined, " металла (трюм: ", GameManager.get_cargo_amount("metal"), ")")
					return
				else:
					print("⚠️ Астероид слишком далеко (подлети ближе)")
			# Если не нашли астероид или он далеко — ничего не делаем

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		try_mine_at_cursor()
		
# ============================================================
# БЛОК 6: ПРОДАЖА
# ============================================================
func sell_cargo():
	var world = get_parent()
	if world and world.has_method("get_nearest_station"):
		var station = world.get_nearest_station(global_position)
		if station and global_position.distance_to(station.global_position) < 150:
			if GameManager.cargo.size() > 0:
				var earned = GameManager.sell_all_cargo()
				print("💰 Продано ресурсов на ", earned, " кредитов")
			else:
				print("📭 Трюм пуст")
		else:
				print("🏭 Нет станции рядом (подлети ближе)")
	


# ============================================================
# БЛОК 5: ЛОГИКА (изменённая добыча)
# ============================================================
func mine_asteroid():
	var world = get_parent()
	if world and world.has_method("get_nearest_asteroid"):
		var asteroid = world.get_nearest_asteroid(global_position)
		if asteroid and global_position.distance_to(asteroid.global_position) < 100:
			# Добываем 10 единиц ресурса (без бонуса пока)
			var mined = asteroid.mine(10)
			if mined > 0:
				# Вместо денег — добавляем в трюм
				GameManager.add_cargo("metal", mined)
				print("⛏️ Добыто: ", mined, " металла (трюм: ", GameManager.get_cargo_amount("metal"), ")")
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
