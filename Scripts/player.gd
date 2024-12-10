extends CharacterBody2D


@export var speed = 60
@export var jump_velocity = -100.0

@onready var sprite = $AnimatedSprite2D
@onready var jump_audio = $JumpAudioStreamPlayer2D
@onready var game_over_menu = $GameOverMenu
@onready var coin_counter = $HUD/CoinCounter

var is_alive = true
var is_on_ladder = false
var grabbed_ladder = false

func _ready() -> void:
	sprite.flip_h = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_alive:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and (is_on_floor() or grabbed_ladder):
			jump_audio.play()
			velocity.y = jump_velocity
			grabbed_ladder = false

		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("left", "right")
		if grabbed_ladder:
			var vertical_direction = Input.get_axis("up", "down")
			velocity.x = direction * speed
			velocity.y = vertical_direction * speed
		elif direction:
			velocity.x = direction * speed
			sprite.flip_h = direction > 0
			sprite.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			sprite.play("default")
		
		if is_on_ladder and Input.is_action_pressed("up"):
			grabbed_ladder = true
			

	move_and_slide()


func update_coin_counter():
	coin_counter.text = str(ScoreManager.coins)


func death():
	game_over_menu.show()
	is_alive = false
	is_on_ladder = false
	sprite.play("death")
	ScoreManager.reset_coins()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		death()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ladder"):
		is_on_ladder = true


func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("Ladder"):
		grabbed_ladder = false
		is_on_ladder = false


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(ScoreManager.main_menu_path)
