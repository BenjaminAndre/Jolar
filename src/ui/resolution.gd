extends PanelContainer

@onready var battle_state_machine: Node = $"../../../BattleStateMachine"
@onready var my_action: RichTextLabel = $MarginContainer/MyAction




func _process(delta: float) -> void:
    visible = battle_state_machine.current_state == Enums.BattleState.ACTIONS_RESOLUTION
    if visible:
        var is_player = battle_state_machine.action_state == Enums.ActionResolutionState.RESOLVING_PLAYER_ACTION
        var override = StyleBoxFlat.new()
        override.set_border_width_all(5)
        if is_player :
            my_action.text = battle_state_machine.last_chosen_capacity.name
            override.border_color = Color.GREEN
        else :
            my_action.text = battle_state_machine.other_capacity.name
        add_theme_stylebox_override("panel", override)
