class_name BaseMenuNavigateButton
extends Button

enum Menu  {
	BASE_MENU,
	PAUSE_BUTTON,
	PAUSE_MENU,
	OPTIONS_MENU,
	CONFIRM_DIALOG_MENU,
	MAIN_MENU
}

@export var MenuOpen : Menu
@export var MenuClose : Menu

func _ready() -> void:
	UIManager.check_enum_consistency(Menu)



func _on_button_up() -> void:
	UIManager.openMenu(MenuOpen)
	UIManager.closeMenu(MenuClose)
