@tool
class_name  ResourceComponent
extends Node2D

@export var MaxValue : int = 0
@export var ResourceName : String = ""
var CurrentValue : int = 0

signal maxValueChanged
signal currentValueChanged

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentValue = MaxValue
	assert(ResourceName != "", "Error: You have not stated a name for this resource")

func MaxValueChanged(deltaChange : int) -> void:
	MaxValue += deltaChange
	emit_signal("maxValueChanged")

func CurrentValueChanged(deltaChange : int) -> void:
	print("gh")
	if CurrentValue >= 0:
		CurrentValue += deltaChange
		CurrentValue = clamp(CurrentValue, 0, MaxValue)
		emit_signal("currentValueChanged")
