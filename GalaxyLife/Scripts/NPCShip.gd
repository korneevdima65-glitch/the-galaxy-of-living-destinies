# ============================================================
# БЛОК 1: НАСЛЕДОВАНИЕ
# ============================================================
extends CharacterBody2D

# ============================================================
# БЛОК 2: ПЕРЕМЕННЫЕ (меняй здесь)
# ============================================================
var npc_name = "Арис"
var speed = 200
var target_position = Vector2.ZERO
var world = null

# ============================================================
# БЛОК 3: СОЗДАНИЕ
# ============================================================
func _ready():
	print("👤 NPC: ", npc_name, " появился")
	choose_new_target()

# ============================================================
# БЛОК 4: ДВИЖЕНИЕ
# ============================================================
func _process(delta):
	var distance = global_position.distance_to(target_position)
	if distance > 10:
		var direction = global_position.direction_to(target_position)
		velocity = direction * speed
		move_and_slide()
		rotation = velocity.angle()
	else:
		velocity = Vector2.ZERO
		choose_new_target()

# ============================================================
# БЛОК 5: ЛОГИКА
# ============================================================
func choose_new_target():
	var world_size = 2000
	target_position = Vector2(
		randf_range(-world_size, world_size),
		randf_range(-world_size, world_size)
	)
