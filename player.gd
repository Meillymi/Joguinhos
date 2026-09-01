extends CharacterBody2D

const RUN_SPEED = 1000.0
const DESACELERACAO = 600.0
const WALK_SPEED = 100.0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# Descobre se o botão de correr está apertado
	var current_speed = SPEED
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = RUN_SPEED
	elif Input.is_key_pressed(KEY_ALT):
		current_speed = WALK_SPEED

	# Aplica a velocidade baseada na direção e se está correndo
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, DESACELERACAO * delta)

	move_and_slide()
