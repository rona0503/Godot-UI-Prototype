extends Control

enum Menu  {
	BASE_MENU,
	PAUSE_BUTTON,
	PAUSE_MENU,
	OPTIONS_MENU,
	CONFIRM_DIALOG_MENU,
	MAIN_MENU
}
@export var MenuName : Menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIManager.check_enum_consistency(Menu)
	UIManager.connect("menuOpened", Callable(self, "_on_Open_Menu"))
	UIManager.connect("menuClosed", Callable(self, "_on_Close_Menu"))
	#if visible == true:
		#UIManager.menuStack.append(MenuName)
	assert(MenuName != Menu.BASE_MENU, name + " menu's Menu Name is not properly set.")
	
	

	
func _on_Open_Menu(menu: int) -> void:
	if menu == MenuName and menu != Menu.BASE_MENU:
		show()

func _on_Close_Menu(menu: int) -> void:
	if menu == MenuName and menu != Menu.BASE_MENU:
		hide()
	
