extends Node2D


@export var speed = 50
@export var is_working = true

@onready var path_follow = $Path2D/PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_working:
		path_follow.progress += speed * delta


func turn_on():
	is_working = true


func turn_off():
	is_working = false
