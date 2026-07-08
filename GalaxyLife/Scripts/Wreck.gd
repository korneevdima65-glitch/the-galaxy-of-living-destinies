extends Area2D


var items = []



var collect_timer = 3.0


func _process(delta):

	collect_timer -= delta

	if collect_timer <= 0:
		collect()




func setup(wreck_items):

	items = wreck_items

	
func collect():

	print("Собраны обломки")

	for item in items:
		GameManager.inventory.append(item)

	print("Новый инвентарь:")
	print(GameManager.inventory)

	queue_free()
