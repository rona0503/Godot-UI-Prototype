extends Button

@export var TargetScene : PackedScene

func _on_button_up() -> void:
	get_tree().change_scene_to_packed(TargetScene)
