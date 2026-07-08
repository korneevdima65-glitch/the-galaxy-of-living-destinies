extends Node2D


var station_name = "Станция Альфа"

var population = 1000

var has_market = true


var missions = [
	{
		"name":"Доставка груза",
		"reward":200
	},
	{
		"name":"Поиск ресурсов",
		"reward":300
	}
]

func _ready():
	
	print("Станция создана:", station_name)
	print("Название:", station_name)
	print("Население:", population)

	var world = get_parent()

	world.stations.append(self)
