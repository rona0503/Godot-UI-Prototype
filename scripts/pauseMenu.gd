extends Control

@onready var resume: Button = $PanelContainer/VBoxContainer/Resume
@onready var options_button: Button = $PanelContainer/VBoxContainer/OptionsButton

func _ready() -> void:
	#Open and Close Menu EventBus Signal Requests
	EventBus.connect("menuOpened", Callable(self, "_on_Open_Pause_Menu"))
	EventBus.connect("menuClosed", Callable(self, "_on_Close_Pause_Menu"))
	#Confirm Dialog Event Bus Requests
	EventBus.connect("confirmed", _on_Confirm)
	EventBus.connect("notConfirmed", _on_Cancel)
	
	resume.button_up.connect(_on_pressed)
	options_button.button_up.connect( _on_options_button_selected)
	

func _on_pressed() -> void:
	get_tree().paused = false
	EventBus.closeMenu(EventBus.Menu.PAUSE_MENU)

func _on_options_button_selected() -> void:
	EventBus.openMenu(EventBus.Menu.OPTIONS_MENU)
	EventBus.closeMenu(EventBus.Menu.PAUSE_MENU)

#Hide and Show Menu
func _on_Open_Pause_Menu(menu : int) -> void:
	if menu == EventBus.Menu.PAUSE_MENU:
		show()
func _on_Close_Pause_Menu(menu : int) -> void:
	if menu == EventBus.Menu.PAUSE_MENU:
		hide()

#Confirm Dialog Choices and Requests
func _on_Confirm(context : String) -> void:
	match context:
		"quit_game":
			get_tree().quit()
func _on_Cancel(context : String) -> void:
	EventBus.openMenu(EventBus.Menu.PAUSE_MENU)
func _on_quit_button_button_up() -> void:
	EventBus.request_Confirm("Are you sure you want to quit?", "Yes", "No", "quit_game")
	EventBus.closeMenu(EventBus.Menu.PAUSE_MENU)
