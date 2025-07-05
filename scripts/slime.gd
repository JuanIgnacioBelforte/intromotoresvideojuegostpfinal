extends CharacterBody2D
class_name Enemy


#Variables

@export_category("⚙️ Config")

@export_group("Options")
@export var score = 100 # Velocidad de movimiento
@export var health = 20 # Salud

@export_group("Motion")
@export var speed = 200 # Velocidad de movimiento
@export var jump = 168 # Salto
@export var gravity = 200 # Gravedad

var death : bool = false

func _process(_delta):
	if health > 0:
		jump_ctrl(2)

func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()

func jump_ctrl(power : float) -> void:
	velocity.y = -jump * power

func damage_ctrl(damage : int) -> void:
	health -= damage
	
	if health <= 0:
		$Sprite.set_animation("Death")
		$Collision.set_deferred("disabled", true)
		gravity = 0
		GLOBAL.score += score


func _on_hit_point_body_entered(body: Node2D) -> void:
	# Verifica si el cuerpo que entró en el Area2D es un enemigo
	if body is Player and velocity.y >= 0:
		body.damage_ctrl()

func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "Death":
		queue_free()
