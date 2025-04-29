extends PanelContainer

@onready var battle_state_machine: Node = $"../../../BattleStateMachine"

func _process(delta: float) -> void:
    visible = battle_state_machine.current_state == Enums.BattleState.PLAYER_CHOOSES_CREATURE_ACTION


func _on_button_up(extra_arg_0: int) -> void:
    Signals.ui_creature_choses.emit(extra_arg_0)
