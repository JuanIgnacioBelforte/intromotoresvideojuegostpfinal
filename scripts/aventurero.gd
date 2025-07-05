extends CharacterBody2D
class_name Player


# Variables
@export_category("⚙️ Config")
@export_group("Required References")
@export var gui: CanvasLayer

@export_group("Motion")
@export var speed = 200 # Velocidad de movimiento
@export var jump_height = -500 # Fuerza del salto
@export var gravity = 800 # Gravedad
@export var damage = 10 # Daño que inflige el personaje
@export var is_attacking = false # Variable para controlar si el personaje está atacando
var death: bool = false

# Señales

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
		is_attacking = false
	# Animación idle
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("idle") # Animación idle
		


func _on_hit_point_body_entered(body: Node2D) -> void:
	# Verifica si el cuerpo que entró en el Area2D es un enemigo
	if body.is_in_group("enemies"):
		# Aplica daño al enemigo
		body.take_damage(damage)

func _on_animaciones_animation_finished() -> void:
	pass # Replace with function body.
