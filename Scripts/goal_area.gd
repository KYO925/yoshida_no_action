extends Area2D


@export var next_stage_num = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Players"):
		ScoreManager.set_next_stage(next_stage_num)
		get_tree().change_scene_to_packed(ScoreManager.stage_number_scene)
