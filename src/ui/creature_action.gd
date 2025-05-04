extends PanelContainer

@onready var battle_state_machine: Node = $"../../../BattleStateMachine"
@onready var this_creature: Node = $"../../../World/ThisCreature"

@onready var action_0: Button = $GridContainer/Action0
@onready var action_1: Button = $GridContainer/Action1
@onready var action_2: Button = $GridContainer/Action2
@onready var action_3: Button = $GridContainer/Action3

func _process(delta: float) -> void:
    visible = battle_state_machine.current_state == Enums.BattleState.PLAYER_CHOOSES_CREATURE_ACTION
    action_0.text = this_creature.creature.moves[0].name
    action_1.text = this_creature.creature.moves[1].name
    action_2.text = this_creature.creature.moves[2].name
    action_3.text = this_creature.creature.moves[3].name


func _on_button_up(extra_arg_0: int) -> void:
    Signals.ui_creature_choses.emit(extra_arg_0)
