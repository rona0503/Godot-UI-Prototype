extends Node

##Menu enum for the UI Manager autoload 
enum Menu  {
	BASE_MENU,
	PAUSE_BUTTON,
	PAUSE_MENU,
	OPTIONS_MENU,
	CONFIRM_DIALOG_MENU,
	MAIN_MENU
}

#Menu Visibility Events
## Emmited when opening a new Menu, used internally by the UIManager.[br][br]
## Menu : Takes a value from the Menu enum
signal menuOpened(menu : int)
## Emmited when closing a new Menu, used internally by the UIManager.[br][br]
## Menu : Takes a value from the Menu enum
signal menuClosed(menu : int)

var currentMenu : int
var previousMenu : int
var menuStack : Array = []

## Used when accessing a new menu [br][br]
## Automatically closes the current menu and opens the target menu. [br][br]
## CurrentMenu : takes the current menu [br][br]
## targetMenu : takes the target menu that want to open [br][br]
## transient : if you do not want to append current menu to stack
func changeMenu(CurrentMenu: int, targetMenu: int, transient: bool = false) -> void:
	previousMenu = CurrentMenu
	currentMenu = targetMenu
	if not transient:
		if previousMenu != null:
			menuStack.append(previousMenu)
	emit_signal("menuOpened", currentMenu)
	emit_signal("menuClosed", CurrentMenu)

## Used when backtracking menus. [br][br]
## Does not need any input as it automatically navigates to the previous menu stored in the stack
func backMenu() -> void:
	if menuStack.size() > 0:
		var prev : int = menuStack.pop_back()
		previousMenu = currentMenu
		currentMenu = prev
		emit_signal("menuClosed", previousMenu)
		emit_signal("menuOpened", currentMenu)

#Confirm Dialog
signal confirm_requested(message: String, ConfirmText: String, CancelText : String, Context : String)
@warning_ignore("unused_signal")
signal confirmed(Context : String)
@warning_ignore("unused_signal")
signal notConfirmed(Context : String)

## A function that requests Confirm Dialog to appear along with chosen parameters [br][br]
## message : used in displaying what message you want to appear[br][br]
## ConfirmText : text displayed in the 'yes' or 'confirm' button [br][br]
## CancelText: text displayed in the no button [br][br]
## Context : in what context is the Confirm Dialog being used for
func request_Confirm(message: String, ConfirmText: String, CancelText : String, Context : String) -> void:
	emit_signal("confirm_requested", message, ConfirmText, CancelText, Context)
	emit_signal("menuOpened", Menu.CONFIRM_DIALOG_MENU)

#Extra functions
## A function that checks local enum to see if they match with Autoload enum. 
## This function was needed as linking the autoload enum to the various scripts is hard
func check_enum_consistency(LocalEnum : Dictionary) -> void:
	assert(LocalEnum == Menu, "Enum Mismatch: Local Menu is not equal to UIManager Menu")
	
##Notifs
signal addDefaultNotifs( title : String, message : String)
signal addNotifs(title : String, message : String, location : int, popStyle : String, duration : float)
	
	
