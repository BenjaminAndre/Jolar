extends Node

var current_state : Enums.BattleState
var last_chosen_capacity : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    Signals.ui_character_choses.connect(_on_character_chosen)
    Signals.ui_creature_choses.connect(_on_creature_chosen)
    Signals.resolution_ended.connect(_on_resolution_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _on_character_chosen(value: Enums.CharacterAction) -> void :
    if current_state == Enums.BattleState.PLAYER_CHOOSES_CHARACTER_ACTION :
        if value == Enums.CharacterAction.COMMAND_CREATURE:
            current_state = Enums.BattleState.PLAYER_CHOOSES_CREATURE_ACTION
        if value == Enums.CharacterAction.CHANGE_CREATURE:
            pass
        if value == Enums.CharacterAction.MOVE:
            pass
        if value == Enums.CharacterAction.FOLLOW:
            pass

func _on_creature_chosen(value: int) -> void :
    if current_state == Enums.BattleState.PLAYER_CHOOSES_CREATURE_ACTION :
        last_chosen_capacity = value
        current_state = Enums.BattleState.ACTIONS_RESOLUTION

func _on_resolution_ended() -> void :
    if current_state == Enums.BattleState.ACTIONS_RESOLUTION :
        current_state = Enums.BattleState.PLAYER_CHOOSES_CHARACTER_ACTION
