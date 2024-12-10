extends Node


@export var stage_number_scene: PackedScene

var coins = 0
var current_stage = 1
var main_menu_path = "res://Scenes/main_menu.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_coins(n=1):
	coins += n


func set_next_stage(n):
	current_stage = n


func reset_coins():
	coins = 0
