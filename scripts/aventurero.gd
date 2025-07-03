extends CharacterBody2D

# Variables

var speed = 200 # Velocidad de movimiento
var jump_height = -400 # Fuerza del salto
var gravity = 800 # Gravedad

var velocity = Vector2.ZERO # Velocidad actual

# Señales

#onready var animatedSprite = $AnimatedSprite # Referencia al nodo AnimatedSprite

func _physics_process(delta):
	# Movimiento horizontal
	velocity.x = 0
	
if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		$AnimatedSprite.flip_h = false # Voltear sprite si es necesario
		$AnimatedSprite.play("run") # Animación de correr
	
	
if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		$AnimatedSprite.flip_h = true # Voltear sprite si es necesario
		$AnimatedSprite.play("run") # Animación de correr
	
# Salto
	
if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite.play("jump") # Animación de salto
	
# Aplicar gravedad
	velocity.y += gravity * delta
	
# Movimiento
	velocity = move_and_slide(velocity, Vector2.UP)
	
# Ataque
	
if Input.is_action_just_pressed("ui_attack"):
		$AnimatedSprite.play("attack") # Animación de ataque
		# Aquí puedes agregar el código para detectar colisiones y aplicar daño

# Animación idle

if velocity.x == 0 and is_on_floor():
		$AnimatedSprite.play("idle") # Animación idle


func _on_animaciones_sprite_frames_changed() -> void:
	pass _physics_process(delta)
