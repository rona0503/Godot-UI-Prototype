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

func _ready() -> void:
	UIManager.check_enum_consistency(Menu)
	UIManager.connect("menuOpened", Callable(self, "_on_Open_Menu"))
	UIManager.connect("menuClosed", Callable(self, "_on_Close_Menu"))
	#if visible == true:
		#UIManager.menuStack.append(MenuName)
	assert(MenuName != Menu.BASE_MENU, name + "'s Menu Name is not properly set.")
	
	

## Triggered when the menuOpened signal was fired and its name is equal to this node name
func _on_Open_Menu(menu: int) -> void:
	if menu == MenuName and menu != Menu.BASE_MENU:
		show()

## Triggered when the menuClosed signal was fired and its name is equal to this node name
func _on_Close_Menu(menu: int) -> void:
	if menu == MenuName and menu != Menu.BASE_MENU:
		hide()
	
