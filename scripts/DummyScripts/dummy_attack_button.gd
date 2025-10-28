extends Button

@export var healthComponent : ResourceComponent
@export var damage : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_button_up() -> void:
	print("HH")
	healthComponent.CurrentValueChanged(-1 * damage)
