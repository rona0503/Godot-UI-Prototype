extends Button

@export var TargetScene : PackedScene
@export var DoLoadingScreen : bool

func _on_button_up() -> void:
	assert(TargetScene != null, "Error: You have not set a target scene for this button!")
	await FadeTransition.fade_out()
	if DoLoadingScreen:
		await LoadingScreen.play()
	get_tree().change_scene_to_packed(TargetScene)
	await FadeTransition.fade_in()
