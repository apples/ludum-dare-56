extends Node
## An empty global variable bag with a togglable debug overlay that displays all variables.
##
## Designed to hold simple global variables.
## A bad pattern, but in a game jam, sometimes you just need to get it done.
##
## Displays a debug overlay when the user hits the F1 key.
## All variables are displayed automatically.

## Emitted when any variable changes.
signal changed()

const DAY_DURATION = 25.0

signal player_hotbar_changed()
var player_hotbar: Array[Blueprint] = [null, null, null, null, null, null]:
	set(v): player_hotbar = v; changed.emit(); player_hotbar_changed.emit()

signal selected_blueprint_changed()
var selected_blueprint: Blueprint = null:
	set(v): selected_blueprint = v; changed.emit(); selected_blueprint_changed.emit()

signal blue_mana_changed()
var blue_starting_mana: int = 0
var blue_income: int = 4
signal blue_temp_income_changed()
var blue_temp_income: int = 0:
	set(v): blue_temp_income = v; changed.emit(); blue_temp_income_changed.emit()
var blue_mana: int = 0:
	set(v): blue_mana = v; changed.emit(); blue_mana_changed.emit()

var red_starting_mana: int = 0
var red_income: int = 5
var red_temp_income: int = 0
var red_mana: int = 0:
	set(v): red_mana = v; changed.emit()

signal phase_changed()
var phase: Enums.Phase = Enums.Phase.STANDBY:
	set(v): phase = v; changed.emit(); phase_changed.emit()

signal rounds_changed()
var rounds: int = 0:
	set(v): rounds = v; changed.emit(); rounds_changed.emit()

var cpu_acting: bool = false:
	set(v): cpu_acting = v; changed.emit()

var upgrades_queued: Array[Enums.Upgrades] = [Enums.Upgrades.STARTER]

var game_level: int = 0

var day_time: float = 0.0

func _ready() -> void:
	reset()

## Reset all variables to their default state.
func reset():
	player_hotbar = [null, null, null, null, null, null]
	selected_blueprint = null
	blue_starting_mana = 0
	blue_income = 4
	blue_temp_income = 0
	blue_mana = 0
	red_starting_mana = 0
	red_income = 4
	red_temp_income = 0
	red_mana = 0
	game_level = 0
	day_time = 0.0
	cpu_acting = false
	phase = Enums.Phase.STANDBY
	rounds = 0
	upgrades_queued = [Enums.Upgrades.STARTER]


#region Debug overlay
var _overlay
func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed:
		match event.physical_keycode:
			KEY_F1:
				if not _overlay:
					_overlay = load("res://autoload/globals/globals_overlay.tscn").instantiate()
					get_parent().add_child(_overlay)
				else:
					_overlay.visible = not _overlay.visible
#endregion
