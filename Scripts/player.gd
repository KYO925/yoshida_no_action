extends CharacterBody2D


@export var speed = 60
@export var jump_velocity = -100.0

@onready var sprite = $AnimatedSprite2D
@onready var jump_audio = $JumpAudioStreamPlayer2D

var is_alive = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_alive:
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


func death():
	is_alive = false
	sprite.play("death")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		death()
