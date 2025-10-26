extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIManager.connect("menuOpened", Callable(self, "_on_Open_Main_Menu"))
	UIManager.connect("menuClosed", Callable(self, "_on_Close_Main_Menu"))
	#Confirm Dialog Event Bus Requests
	UIManager.connect("confirmed", _on_Confirm)
	UIManager.connect("notConfirmed", _on_Cancel)
	
func _on_Open_Main_Menu(menu : int) -> void:
	if menu == UIManager.Menu.MAIN_MENU:
		show()

func _on_Close_Main_Menu(menu : int) -> void:
	if menu == UIManager.Menu.MAIN_MENU:
		hide()



func _on_options_button_up() -> void:
	UIManager.openMenu(UIManager.Menu.OPTIONS_MENU)
	UIManager.closeMenu(UIManager.Menu.MAIN_MENU)

#Confirm Dialog Choices and Requests
func _on_Confirm(context : String) -> void:
	match context:
		"quit_game":
			get_tree().quit()
func _on_Cancel(_context : String) -> void:
	UIManager.openMenu(UIManager.Menu.PAUSE_MENU)
	UIManager.closeMenu(UIManager.Menu.MAIN_MENU)
func _on_quit_button_up() -> void:
	UIManager.request_Confirm("Are you sure you want to quit?", "Yes", "No", "quit_game")
	UIManager.closeMenu(UIManager.Menu.MAIN_MENU)
