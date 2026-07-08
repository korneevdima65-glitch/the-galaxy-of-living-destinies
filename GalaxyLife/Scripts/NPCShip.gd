extends CharacterBody2D

var world
var npc_name = "Арис"
var money = 50
var goal = "Заработать деньги"
var state = "ищет работу"
var think_time = 5.0


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
	
func make_decision():

	if state == "ищет работу":

		print(npc_name, " нашёл работу")

		state = "выполняет заказ"


	elif state == "выполняет заказ":

		print(npc_name, " выполнил заказ")

		var reward = 200

		money += reward

		print("Награда:", reward)

		state = "получил деньги"


	elif state == "получил деньги":

		print(npc_name, " баланс: ", money, " кредитов")

		state = "ищет работу"

var timer = 0.0

func _process(delta):

	timer += delta

	if timer >= think_time:
		timer = 0
		make_decision()
