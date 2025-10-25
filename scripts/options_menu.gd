extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIManager.connect("menuOpened", Callable(self, "_on_open_options"))
	UIManager.connect("menuClosed", Callable(self, "_on_close_options"))
	
func _on_open_options(menu : int) -> void:
	if menu == UIManager.Menu.OPTIONS_MENU:
		show()
func _on_close_options(menu : int) -> void:
	if menu == UIManager.Menu.OPTIONS_MENU:
		hide()


func _on_back_button_up() -> void:
	UIManager.backMenu()
