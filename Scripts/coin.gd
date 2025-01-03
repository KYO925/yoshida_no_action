extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		hide()
		ScoreManager.add_coins()
		body.update_coin_counter()
		$AudioStreamPlayer2D.play()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
