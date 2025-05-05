extends PanelContainer

@onready var battle_state_machine: Node = $"../../BattleStateMachine"
@onready var build_metadata: PanelContainer = $"../BuildMetadata"

@onready var battle_value: RichTextLabel = $MarginContainer/VBoxContainer/BattleState/Value
@onready var action_value: RichTextLabel = $MarginContainer/VBoxContainer/ResolveState/Value

func _ready() -> void:
    if !OS.is_debug_build():
        hide()
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    battle_value.text = Enums.BattleState.keys()[battle_state_machine.current_state]
    action_value.text = Enums.ActionResolutionState.keys()[battle_state_machine.action_state]
