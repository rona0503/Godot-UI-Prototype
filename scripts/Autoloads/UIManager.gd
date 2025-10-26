extends Node

enum Menu  {
	BASE_MENU,
	PAUSE_BUTTON,
	PAUSE_MENU,
	OPTIONS_MENU,
	CONFIRM_DIALOG_MENU,
	MAIN_MENU
}
#Menu Visibility Events
signal menuOpened(menu : int)
signal menuClosed(menu : int)
signal menuChanged(previousMenu : int, currentMenu : int)

var currentMenu : int
var previousMenu : int
var menuStack : Array = []

func openMenu(menu : int, transient : bool = false) -> void:
	if not transient:
		if currentMenu != null:
			menuStack.append(currentMenu)
		previousMenu = currentMenu
	currentMenu = menu
	
	emit_signal("menuChanged", previousMenu, currentMenu)
	emit_signal("menuOpened", currentMenu)

func backMenu() -> void:
	if menuStack.size() > 0:
		var prev : int = menuStack.pop_back()
		previousMenu = currentMenu
		currentMenu = prev
		emit_signal("menuClosed", previousMenu)
		emit_signal("menuChanged", previousMenu, currentMenu)
		emit_signal("menuOpened", currentMenu)

func closeMenu(menu : int) -> void:
	emit_signal("menuClosed", menu)

#Confirm Dialog
signal confirm_requested(message: String, ConfirmText: String, CancelText : String, Context : String)
@warning_ignore("unused_signal")
signal confirmed(Context : String)
@warning_ignore("unused_signal")
signal notConfirmed(Context : String)
func request_Confirm(message: String, ConfirmText: String, CancelText : String, Context : String) -> void:
	emit_signal("confirm_requested", message, ConfirmText, CancelText, Context)
	emit_signal("menuOpened", Menu.CONFIRM_DIALOG_MENU)
	
#Extra functions
func check_enum_consistency(LocalEnum : Dictionary) -> void:
	assert(LocalEnum == Menu, "Enum Mismatch: Local Menu is not equal to UIManager Menu")
	
	
