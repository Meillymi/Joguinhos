extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animacao: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. Aplica a gravidade enquanto estiver no ar
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Inicia o salto se estiver no chão e apertar o botão de pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Calcula o movimento horizontal e a orientação visual
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animacao.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Move o personagem com a física
	move_and_slide()

	# 5. Controle de Animação com Prioridades (Atividade 4)
	if not is_on_floor():
		# Prioridade 1: No ar (subindo ou caindo)
		animacao.play("jump")
	elif direction != 0:
		# Prioridade 2: No chão e se movendo
		animacao.play("run")
	else:
		# Prioridade 3: No chão e parado
		animacao.play("idle")

	# 6. Reset de posição e velocidade ao cair da plataforma
	if position.y > 500:
		position.y = 0
		velocity = Vector2.ZERO
