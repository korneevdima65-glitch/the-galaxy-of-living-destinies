# ==================================================
# SCRIPT: NPCShip.gd
# Описание: ИИ корабля жителя галактики
# Версия: 0.1
# ==================================================
extends CharacterBody2D
# =====================
# ДАННЫЕ NPC
# =====================
var world
var npc_name = "Арис"
var money = 50
var cargo = []
var goal = "Заработать деньги"
var state = "ищет работу"
# =====================
# СИСТЕМА ЗАДАНИЙ
# =====================
var think_time = 5.0
var current_mission = null
var last_mission = ""
# =====================
# ДВИЖЕНИЕ NPC
# =====================
var target_position = Vector2.ZERO
var speed = 500
# =====================
# СОЗДАНИЕ NPC
# =====================
func _ready():
	print("Появился NPC:", npc_name)
	print("Деньги:", money)
	print("Цель:", goal)
	print("Состояние:", state)
	world = get_parent()
	scan_world()
	make_decision()
func scan_world():
	print(npc_name, " сканирует мир")
	print("Станций найдено:", world.stations.size())
# =====================
# ЛОГИКА ИИ
# =====================
func make_decision():
	if state == "ищет работу":
		if world.stations.size() > 0:
			var station = world.stations[0]
			var available_missions = []
			for mission in station.missions:
				if mission["name"] != last_mission:
					available_missions.append(mission)
			if available_missions.size() > 0:
				current_mission = available_missions[
					randi() % available_missions.size()
				]
				last_mission = current_mission["name"]
			else:
				current_mission = station.missions[
					randi() % station.missions.size()
				]
			if typeof(current_mission["target"]) == TYPE_STRING and current_mission["target"] == "asteroid":
				if world.asteroids.size() > 0:
					var asteroid = world.asteroids[0]
					target_position = asteroid.global_position
					current_mission["object"] = asteroid
				else:
					print("Нет доступных астероидов")
					return
			else:
				target_position = current_mission["target"]
			print(
			npc_name,
			" взял задание: ",
			current_mission["name"]
			)
			print("Цель:", target_position)
			state = "летит к цели"
# =====================
# ВЫПОЛНЕНИЕ ЗАДАНИЯ
# =====================
	elif state == "выполняет заказ":
			if current_mission["name"] == "Поиск ресурсов":
				print(npc_name, " добывает ресурсы")
				var asteroid = current_mission["object"]
				asteroid.mine(100)
				cargo.append({
					"name":"Металл",
					"amount":100
				})
				print(npc_name, " получил 100 металла")
				state = "возвращается на станцию"
				target_position = world.stations[0].global_position
			else:
				print(npc_name, " выполнил заказ")
				var reward = current_mission["reward"]
				money += reward
				print("Награда:", reward)
				state = "получил деньги"
	elif state == "разгружает ресурсы":
		var station = world.stations[0]
		var metal_amount = 0
		for item in cargo:
			if item["name"] == "Металл":
				metal_amount += item["amount"]
		station.storage["metal"] += metal_amount
		print(
		npc_name,
		" выгрузил металл на станцию:",
		metal_amount
		)
		cargo.clear()
		state = "получил деньги"
	elif state == "получил деньги":
		print(npc_name, " баланс: ", money, " кредитов")
		state = "ищет работу"
var timer = 0.0
# =====================
# ЦИКЛ ЖИЗНИ NPC
# =====================
func _process(delta):
	# Полёт к цели (астероид или другая точка)
	if state == "летит к цели" or state == "возвращается на станцию":
		var distance = global_position.distance_to(target_position)
		if distance > 10:
			var direction = global_position.direction_to(target_position)
			velocity = direction * speed
			move_and_slide()
		else:
			if state == "летит к цели":
				print(npc_name, " достиг цели")
				state = "выполняет заказ"
			elif state == "возвращается на станцию":
				print(npc_name, " прибыл на станцию")
				state = "разгружает ресурсы"
	# Таймер принятия решений
	timer += delta
	if timer >= think_time:
		timer = 0
		make_decision()

#Тут конец название скрипта NPCShip
