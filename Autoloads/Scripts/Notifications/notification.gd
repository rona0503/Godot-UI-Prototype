extends Control
@onready var panel_container: PanelContainer = $PanelContainer

@onready var Title: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/Title
@onready var Message: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/Message

var PanelSize : Vector2
func set_notification(title : String, message : String) -> void:
	Title.text = title
	Message.text = message
	await  get_tree().process_frame
	PanelSize= panel_container.size
	print(panel_container.size)

func set_message_anchor(location : int = Control.PRESET_TOP_RIGHT) -> void:
	await get_tree().process_frame
	panel_container.set_anchors_preset(location)
