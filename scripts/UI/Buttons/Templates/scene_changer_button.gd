extends Button

@export var TargetScene : PackedScene

func _on_button_up() -> void:
	assert(TargetScene != null, "Error: You have not set a target scene for this button!")
	get_tree().change_scene_to_packed(TargetScene)
