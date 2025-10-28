@tool
extends Control

@export var Resources : ResourceComponent

@onready var resource_label: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/ResourceLabel
@onready var current_resource_value: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/CurrentResourceValue
@onready var max_resource_value: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/MaxResourceValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_label.text = Resources.ResourceName
	current_resource_value.text = str(Resources.CurrentValue)
	max_resource_value.text = str(Resources.MaxValue)
	
	Resources.connect("maxValueChanged", onMaxValueChange)
	Resources.connect("currentValueChanged", onCurrentValueChange)
	
func onMaxValueChange(newMaxValue : int) -> void:
	max_resource_value.text = str(newMaxValue)
	
func onCurrentValueChange(newCurrentValue : int) -> void:
	var tween : Tween = create_tween()
	tween.tween_method(updateValue, int(current_resource_value.text), newCurrentValue, 0.15)
func updateValue(value : float) -> void:
	current_resource_value.text = str(int(round(value)))
