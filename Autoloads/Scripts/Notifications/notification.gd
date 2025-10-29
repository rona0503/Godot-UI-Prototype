extends Control
@onready var Title: Label = $CenterContainer/PanelContainer/MarginContainer/PanelContainer/HBoxContainer/Title
@onready var Message: Label = $CenterContainer/PanelContainer/MarginContainer/PanelContainer/HBoxContainer/Message

func set_notification(title : String, message : String) -> void:
	Title.text = title
	Message.text = message
