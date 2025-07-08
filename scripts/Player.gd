extends CharacterBody2D
class_name Player

# Variables
var axis : Vector2 = Vector2.ZERO
var death : bool = false
var damage = 10

@export_category("⚙️ Config")
@export_group("Required References")
@export var gui: CanvasLayer

@export_group("Motion")
@export var speed = 100 # Velocidad de movimiento
@export var jump = 168 # Salto
@export var gravity = 10 # Gravedad

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()

func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_left")) - int(Input.is_action_pressed("ui_right"))
	return axis.normalized()

func motion_ctrl() -> void:
	if not get_axis().x == 0:
		$Sprite.scale.x = get_axis().x
	
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide()
	
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$Sprite.set_animation("run")
			else:
				$Sprite.set_animation("Idle")
		false:
			if velocity.y < 0:
				$Sprite.set_animation("Jump")
			else:
				$Sprite.set_animation("Fall")

func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()

func jump_ctrl(power : float) -> void:
	velocity.y = -jump * power
	#$Audio/jump.play()

func damage_ctrl() -> void:
	death = true
	$Sprite.set_animation("Death")

func _on_hit_point_body_entered(body: Node2D) -> void:
	# Verifica si el cuerpo que entró en el Area2D es un enemigo
	if body is Enemy and velocity.y >= 0:
		#$Audio/Hit.play()
		body.damage_ctrl(1)
		jump_ctrl(0.75)

func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "Death":
		gui.game_over()
