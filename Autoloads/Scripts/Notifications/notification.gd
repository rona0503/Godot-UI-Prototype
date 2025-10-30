@tool
extends Control
@onready var Notification_container: PanelContainer = $PanelContainer

@onready var Title: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/Title
@onready var Message: Label = $PanelContainer/MarginContainer/PanelContainer/HBoxContainer/Message
@export var Location : int

var PanelPosition : Vector2
var PanelSize : Vector2

var Notification_Postions : Dictionary 

func set_notification(title : String, message : String) -> void:
	Title.text = title
	Message.text = message
	PanelSize = Notification_container.size

func set_message_initial_position(initialPosition : String = "Top_Right") -> void:
	Notification_Postions = {
		"Top_Left" : Control.PRESET_TOP_LEFT,
		"Top_Middle" : Control.PRESET_CENTER_TOP,
		"Top_Right" : Control.PRESET_TOP_RIGHT,
		"Center_Left" : Control.PRESET_CENTER_LEFT,
		"Center" : Control.PRESET_CENTER,
		"Center_Right" : Control.PRESET_CENTER_RIGHT,
		"Bottom_Left" : Control.PRESET_BOTTOM_LEFT,
		"Bottom_Middle" : Control.PRESET_CENTER_BOTTOM,
		"Bottom_Right" : Control.PRESET_BOTTOM_RIGHT
	}
	assert(Notification_Postions.has(initialPosition), "Error: You have set up a wrong initial position")
	#Notification_container.position = Notification_Postions[initialPosition]
	Notification_container.set_anchors_and_offsets_preset(Notification_Postions[initialPosition])
	PanelPosition = Notification_container.position
func _ready() -> void:
	pass
