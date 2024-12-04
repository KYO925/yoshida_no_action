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
		sprite.flip_h = direction > 0
		direction = get_wall_normal().x

	move_and_slide()
