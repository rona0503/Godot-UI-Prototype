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
	
func onMaxValueChange() -> void:
	max_resource_value.text = str(Resources.MaxValue)
	
func onCurrentValueChange() -> void:
	current_resource_value.text = str(Resources.CurrentValue)
