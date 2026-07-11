# ============================================================
# БЛОК 1: НАСЛЕДОВАНИЕ
# ============================================================
extends Node

# ============================================================
# БЛОК 2: ПЕРЕМЕННЫЕ (меняй здесь)
# ============================================================
var player_name = "Капитан"
var player_money = 100
var player_health = 100
var player_energy = 100

# Инвентарь (список словарей)
var inventory = []

# ============================================================
# БЛОК 3: ФУНКЦИИ СОЗДАНИЯ
# ============================================================
func _ready():
	print("✅ GameManager загружен")

# ============================================================
# БЛОК 4: ЛОГИКА (можно менять)
# ============================================================
func add_money(amount):
	player_money += amount
	print("💰 Деньги: ", player_money)

func add_health(amount):
	player_health = min(player_health + amount, 100)
	print("❤️ Здоровье: ", player_health)

func add_energy(amount):
	player_energy = min(player_energy + amount, 100)
	print("⚡ Энергия: ", player_energy)

func add_item(item_name, item_type):
	inventory.append({"name": item_name, "type": item_type})
	print("📦 Добавлен предмет: ", item_name)

# ============================================================
# БЛОК 5: СБРОС
# ============================================================
func reset_game():
	player_money = 100
	player_health = 100
	player_energy = 100
	inventory.clear()
	print("🔄 Игра сброшена")
