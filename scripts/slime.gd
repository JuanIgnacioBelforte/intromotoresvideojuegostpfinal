extends CharacterBody2D
class_name Enemy


#Variables

@export_category("⚙️ Config")

@export_group("Options")
@export var score = 100 # Velocidad de movimiento
@export var health = 20 # Salud

@export_group("Motion")
#@export var speed = 100 # Velocidad de movimiento
@export var salto = 168 # Salto
@export var gravity = 10 # Gravedad
@export var jump_strength = 500  # Fuerza de salto

var death : bool = false
var jump_timer = 10  # Temporizador para controlar cuando saltar

func _process(_delta):
	if health > 0:
		jump_ctrl(2)
	
	# Actualizamos la IA para que salte después de cierto tiempo o cuando se cumpla una condición.
	jump_timer -= _delta
	
	# La IA decide saltar cuando el temporizador llega a cero
	if jump_timer <= 0:
		jump()
		jump_timer = randf_range(1.0, 3.0)  # Cambia el tiempo entre saltos, aleatorio entre 1 y 3 segundos
	

func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()

func jump_ctrl(power : float) -> void:
	velocity.y = -salto * power

func damage_ctrl(damage : int) -> void:
	health -= damage
	
	if health <= 0:
		$Sprite.set_animation("Death")
		$Collision.set_deferred("disabled", true)
		gravity = 0
		GLOBAL.score += score

# Función para hacer que el enemigo salte
func jump():
	# Añadimos la velocidad vertical para que el enemigo salte
	velocity.y = jump_strength


func _on_hit_point_body_entered(body: Node2D) -> void:
	# Verifica si el cuerpo que entró en el Area2D es un enemigo
	if body is Player and velocity.y >= 0:
		body.damage_ctrl()

func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "Death":
		queue_free()
