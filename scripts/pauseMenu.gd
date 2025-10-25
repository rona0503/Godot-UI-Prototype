extends Control

@onready var resume: Button = $PanelContainer/VBoxContainer/Resume
@onready var options_button: Button = $PanelContainer/VBoxContainer/OptionsButton

func _ready() -> void:
	#Open and Close Menu UIManager Signal Requests
	UIManager.connect("menuOpened", Callable(self, "_on_Open_Pause_Menu"))
	UIManager.connect("menuClosed", Callable(self, "_on_Close_Pause_Menu"))
	#Confirm Dialog Event Bus Requests
	UIManager.connect("confirmed", _on_Confirm)
	UIManager.connect("notConfirmed", _on_Cancel)
	
	resume.button_up.connect(_on_pressed)
	options_button.button_up.connect( _on_options_button_selected)
	

func _on_pressed() -> void:
	get_tree().paused = false
	UIManager.closeMenu(UIManager.Menu.PAUSE_MENU)

func _on_options_button_selected() -> void:
	UIManager.openMenu(UIManager.Menu.OPTIONS_MENU)
	UIManager.closeMenu(UIManager.Menu.PAUSE_MENU)

#Hide and Show Menu
func _on_Open_Pause_Menu(menu : int) -> void:
	if menu == UIManager.Menu.PAUSE_MENU:
		show()
func _on_Close_Pause_Menu(menu : int) -> void:
	if menu == UIManager.Menu.PAUSE_MENU:
		hide()

#Confirm Dialog Choices and Requests
func _on_Confirm(context : String) -> void:
	match context:
		"quit_game":
			get_tree().quit()
func _on_Cancel(context : String) -> void:
	UIManager.openMenu(UIManager.Menu.PAUSE_MENU)
func _on_quit_button_button_up() -> void:
	UIManager.request_Confirm("Are you sure you want to quit?", "Yes", "No", "quit_game")
	UIManager.closeMenu(UIManager.Menu.PAUSE_MENU)
