extends CanvasLayer
@onready var Confirm: Button = $"CenterContainer/Dialog Panel/MarginContainer/VBoxContainer/HBoxContainer/Confirm"
@onready var NotConfirm: Button = $"CenterContainer/Dialog Panel/MarginContainer/VBoxContainer/HBoxContainer/Cancel"
@onready var label: Label = $"CenterContainer/Dialog Panel/MarginContainer/VBoxContainer/Label"
var currentContext : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIManager.connect("confirm_requested",  _on_Confirm_Requested)
	hide()
	

func _on_Confirm_Requested(message : String, ConfirmText : String, CancelText : String, Context : String) -> void:
	label.text = message
	Confirm.text = ConfirmText
	NotConfirm.text = CancelText
	currentContext = Context
	show()

func _on_confim_button_up() -> void:
	UIManager.emit_signal("confirmed", currentContext)
	UIManager.emit_signal("menuClosed", UIManager.Menu.CONFIRM_DIALOG_MENU)
	hide()

func _on_cancel_button_up() -> void:
	UIManager.emit_signal("notConfirmed", currentContext)
	UIManager.emit_signal("menuClosed", UIManager.Menu.CONFIRM_DIALOG_MENU)
	hide()
