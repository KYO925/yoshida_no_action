extends CharacterBody2D


@export var speed = 60
@export var jump_velocity = -100.0

@onready var sprite = $AnimatedSprite2D
@onready var jump_audio = $JumpAudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "Platform" and get_floor_normal() == Vector2.UP:
			var platform_position = collision.get_collider().global_position
			position = (global_position - platform_position) + platform_position

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_audio.play()
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		sprite.flip_h = direction > 0
		sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.play("default")

	move_and_slide()
