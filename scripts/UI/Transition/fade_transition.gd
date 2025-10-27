extends CanvasLayer


@onready var color_rect: ColorRect = $ColorRect


func fade_in(fade_time : float = 0.3) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, fade_time)
	await tween.finished

func fade_out(fade_time : float = 0.25) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, fade_time)
	await tween.finished
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass
