@tool
extends Control

@export var resources : ResourceComponent

@onready var progress_bar: ProgressBar = $PanelContainer/MarginContainer/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await resources.ready
	progress_bar.max_value = resources.MaxValue
	progress_bar.value = resources.CurrentValue
	
	resources.connect("maxValueChanged", onMaxValueChanged)
	resources.connect("currentValueChanged", onCurrentValueChanged)
	
func onMaxValueChanged(newMaxValue : int) -> void:
	progress_bar.max_value = newMaxValue

func onCurrentValueChanged(newCurrentValue : int) -> void:
	var tween : Tween = create_tween()
	
	tween.tween_property(progress_bar, "value", newCurrentValue, 0.15)
