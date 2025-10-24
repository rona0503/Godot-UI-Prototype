extends Control
@onready var Confirm: Button = $PanelContainer/VBoxContainer/HBoxContainer/Confirm
@onready var NotConfirm: Button = $PanelContainer/VBoxContainer/HBoxContainer/Cancel
@onready var label: Label = $PanelContainer/VBoxContainer/Label

var currentContext : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("confirm_requested",  _on_Confirm_Requested)
	hide()
	

func _on_Confirm_Requested(message : String, ConfirmText : String, CancelText : String, Context : String) -> void:
	label.text = message
	Confirm.text = ConfirmText
	NotConfirm.text = CancelText
	currentContext = Context
	show()

func _on_confim_button_up() -> void:
	EventBus.emit_signal("confirmed", currentContext)
	EventBus.emit_signal("menuClosed", EventBus.Menu.CONFIRM_DIALOG_MENU)
	hide()

func _on_cancel_button_up() -> void:
	EventBus.emit_signal("notConfirmed", currentContext)
	EventBus.emit_signal("menuClosed", EventBus.Menu.CONFIRM_DIALOG_MENU)
	hide()
