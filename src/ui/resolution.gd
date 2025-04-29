extends PanelContainer

const TIME_TO_RESOLVE : float = 4.0

@onready var battle_state_machine: Node = $"../../../BattleStateMachine"
@onready var my_action: RichTextLabel = $MarginContainer/MyAction


var time_spent_in_resolution : float = 0.0


func _process(delta: float) -> void:
    visible = battle_state_machine.current_state == Enums.BattleState.ACTIONS_RESOLUTION
    if visible:
        my_action.text = "ACTION " + str(battle_state_machine.last_chosen_capacity)
        time_spent_in_resolution += delta
    else :
        time_spent_in_resolution = 0.0
    
    
    if time_spent_in_resolution > TIME_TO_RESOLVE:
        Signals.resolution_ended.emit()
