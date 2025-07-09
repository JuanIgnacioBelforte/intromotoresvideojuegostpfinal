extends CharacterBody2D
class_name Enemy

# ⚙️ CONFIGURACIONES EXPORTADAS DESDE EL EDITOR
@export_category("⚙️ Config")

@export_group("Options")
@export var score = 100           # Puntos al morir
@export var health = 20           # Vida

@export_group("Motion")
@export var salto = 168           # No usado (podés eliminar si no lo usás)
@export var gravity = 10          # Gravedad
@export var jump_strength = 500   # Fuerza del salto hacia arriba

# ⚙️ VARIABLES INTERNAS
var death : bool = false
var jump_timer = 1.0              # Tiempo hasta el próximo salto

# Se ejecuta al iniciar la escena
func _ready():
	jump_timer = randf_range(1.0, 3.0)

# Se ejecuta cada frame de física
func _physics_process(delta):
	if death:
		death_ctrl()
		return

	# Aplicar gravedad
	velocity.y += gravity

	# Contador de salto aleatorio
	jump_timer -= delta
	if jump_timer <= 0:
		jump()
		jump_timer = randf_range(1.0, 3.0)

	# Mover al enemigo
	move_and_slide()

# Función de salto
func jump():
	velocity.y = -jump_strength
	# Podés agregar animación o sonido aquí

# Movimiento en estado de muerte
func death_ctrl():
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()

# Lógica de daño recibido
func damage_ctrl(damage : int):
	health -= damage

	if health <= 0 and not death:
		death = true
		$Sprite.set_animation("Death")
		$Collision.set_deferred("disabled", true)
		gravity = 0
		GLOBAL.score += score

# Detección de colisión con el jugador
func _on_hit_point_body_entered(body: Node2D):
	if body is Player and velocity.y >= 0:
		body.damage_ctrl()  # Asegurate de que el jugador tenga esta función

# Se llama cuando termina la animación de muerte
func _on_sprite_animation_finished():
	if $Sprite.animation == "Death":
		queue_free()
