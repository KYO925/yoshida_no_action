extends CharacterBody2D


@onready var sprite = $AnimatedSprite2D

var is_alive = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func death():
	is_alive = false
	sprite.play("death")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		death()
