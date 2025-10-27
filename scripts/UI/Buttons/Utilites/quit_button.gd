extends BaseMenuNavigateButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#Confirm Dialog Event Bus Requests
	UIManager.connect("confirmed", _on_Confirm)
	UIManager.connect("notConfirmed", _on_Cancel)

func _on_Confirm(context : String) -> void:
	match context:
		"quit_game":
			get_tree().quit()
func _on_Cancel(_context : String) -> void:
	UIManager.openMenu(MenuClose)
func _on_button_up() -> void:
	UIManager.request_Confirm("Are you sure you want to quit?", "Yes", "No", "quit_game")
	super._on_button_up()
