# ============================================================
# БЛОК 1: НАСЛЕДОВАНИЕ
# ============================================================
extends Node

# ============================================================
# БЛОК 2: ПЕРЕМЕННЫЕ
# ============================================================
var player_name = "Капитан"
var player_money = 100
var player_health = 100
var player_energy = 100
var ship_type = "scout"  # scout, miner, trader, military, science

# ТРЮМ (инвентарь ресурсов)
var cargo = []  # [{"type": "metal", "amount": 100}, ...]

# ============================================================
# БЛОК 3: ФУНКЦИИ ДЛЯ ТРЮМА (НОВЫЕ)
# ============================================================

# Добавить ресурс в трюм
func add_cargo(type, amount):
	for item in cargo:
		if item["type"] == type:
			item["amount"] += amount
			print("📦 +", amount, " ", type, " (всего: ", item["amount"], ")")
			return
	cargo.append({"type": type, "amount": amount})
	print("📦 +", amount, " ", type, " (новый ресурс)")

# Удалить ресурс из трюма (возвращает true, если удалось)
func remove_cargo(type, amount):
	for i in range(cargo.size()):
		if cargo[i]["type"] == type:
			if cargo[i]["amount"] >= amount:
				cargo[i]["amount"] -= amount
				if cargo[i]["amount"] == 0:
					cargo.remove_at(i)
				return true
			else:
				return false
	return false

# Получить количество конкретного ресурса
func get_cargo_amount(type):
	for item in cargo:
		if item["type"] == type:
			return item["amount"]
	return 0

# Получить общее количество ресурсов в трюме
func get_total_cargo():
	var total = 0
	for item in cargo:
		total += item["amount"]
	return total

# Получить стоимость всего трюма (цена за металл = 5 кредитов)
func get_cargo_value():
	var price_per_unit = 5
	var total = 0
	for item in cargo:
		total += item["amount"] * price_per_unit
	return total

# Продать всё из трюма
func sell_all_cargo():
	var earned = get_cargo_value()
	player_money += earned
	cargo.clear()
	print("💰 Продано всё за ", earned, " кредитов")
	return earned

# ============================================================
# БЛОК 4: СТАРЫЕ ФУНКЦИИ (без изменений)
# ============================================================
func _ready():
	print("✅ GameManager загружен")

func add_money(amount):
	player_money += amount
	print("💰 Деньги: ", player_money)

func add_health(amount):
	player_health = min(player_health + amount, 100)

func add_energy(amount):
	player_energy = min(player_energy + amount, 100)

func reset_game():
	player_money = 100
	player_health = 100
	player_energy = 100
	cargo.clear()
	print("🔄 Игра сброшена")
