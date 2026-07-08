extends CharacterBody2D


var ship_name = "Старый разведчик"

var level = 1
var experience = 0
var health = 100
var fuel = 100
var destroy_timer = 2.0
var wreck_scene = preload("res://GalaxyLife/Scenes/Wreck.tscn")



func _ready():
	print("Корабль создан")
	print("Корабль:", ship_name)
	

func _process(delta):

	destroy_timer -= delta

	if destroy_timer <= 0:
		destroy_ship()
	
	
func destroy_ship():

	print("Корабль уничтожен")
	
	var wreck_items = []

	for item in GameManager.inventory:
		wreck_items.append(item)
		
	GameManager.inventory.clear()


	var wreck = wreck_scene.instantiate()

	get_parent().add_child(wreck)

	wreck.global_position = global_position

	wreck.setup(wreck_items)

	print("Обломки созданы на месте гибели")
	
	queue_free()
