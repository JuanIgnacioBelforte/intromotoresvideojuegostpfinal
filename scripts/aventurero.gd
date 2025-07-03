extends CharacterBody2D
class_name Player


# Variables
@export var speed = 200 # Velocidad de movimiento
@export var jump_height = -500 # Fuerza del salto
@export var gravity = 800 # Gravedad

# Señales

@onready var animatedSprite = $AnimatedSprite # Referencia al nodo AnimatedSprite


func _physics_process(delta):
	# Movimiento horizontal
	velocity.x = 0

	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		$AnimatedSprite2D.flip_h = false # Voltear sprite si es necesario
		$AnimatedSprite2D.play("run") # Animación de correr

	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		$AnimatedSprite2D.flip_h = true # Voltear sprite si es necesario
		$AnimatedSprite2D.play("run") # Animación de correr

	# Salto

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("jump") # Animación de salto

	# Aplicar gravedad
	velocity.y += gravity * delta

	# Movimiento
	self.velocity = velocity
	move_and_slide()

	# Ataque

	if Input.is_action_just_pressed("ui_attack"):
		$AnimatedSprite2D.play("attack") # Animación de ataque
		# Aquí puedes agregar el código para detectar colisiones y aplicar daño

	# Animación idle

	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("idle") # Animación idle
