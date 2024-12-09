extends Area2D


@export var detection_target = "Players"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not get_parent().has_method("turn_on"):
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(detection_target):
		print("on")
		get_parent().turn_on()
