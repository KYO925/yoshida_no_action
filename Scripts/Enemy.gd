extends CharacterBody2D


@export var direction = -1
var speed = 20

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if direction:
		sprite.play("run")
		velocity.x = direction * speed
	
	if is_on_wall():
		direction = get_wall_normal().x
		sprite.flip_h = direction > 0

	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		sprite.flip_h = direction > 0
		direction = get_wall_normal().x
