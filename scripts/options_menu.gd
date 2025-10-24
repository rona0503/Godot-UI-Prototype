extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("menuOpened", Callable(self, "_on_open_options"))
	EventBus.connect("menuClosed", Callable(self, "_on_close_options"))
	
func _on_open_options(menu : int) -> void:
	if menu == EventBus.Menu.OPTIONS_MENU:
		show()
func _on_close_options(menu : int) -> void:
	if menu == EventBus.Menu.OPTIONS_MENU:
		hide()


func _on_back_button_up() -> void:
	EventBus.backMenu()
