extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("menuOpened", Callable(self, "_on_Open_Main_Menu"))
	EventBus.connect("menuClosed", Callable(self, "_on_Close_Main_Menu"))
	#Confirm Dialog Event Bus Requests
	EventBus.connect("confirmed", _on_Confirm)
	EventBus.connect("notConfirmed", _on_Cancel)
	
func _on_Open_Main_Menu(menu : int) -> void:
	if menu == EventBus.Menu.MAIN_MENU:
		show()

func _on_Close_Main_Menu(menu : int) -> void:
	if menu == EventBus.Menu.MAIN_MENU:
		hide()


func _on_options_button_up() -> void:
	EventBus.openMenu(EventBus.Menu.OPTIONS_MENU)
	EventBus.closeMenu(EventBus.Menu.MAIN_MENU)

#Confirm Dialog Choices and Requests
func _on_Confirm(context : String) -> void:
	match context:
		"quit_game":
			get_tree().quit()
func _on_Cancel(context : String) -> void:
	EventBus.openMenu(EventBus.Menu.PAUSE_MENU)
	EventBus.closeMenu(EventBus.Menu.MAIN_MENU)
func _on_quit_button_up() -> void:
	EventBus.request_Confirm("Are you sure you want to quit?", "Yes", "No", "quit_game")
	EventBus.closeMenu(EventBus.Menu.MAIN_MENU)
