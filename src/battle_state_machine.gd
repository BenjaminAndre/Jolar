extends Node

const TIME_TO_PREPARE : float = 3.0
@onready var this_creature: Node3D = $"../World/ThisCreature"
@onready var other_creature: Node3D = $"../World/OtherCreature"

var current_state : Enums.BattleState
var last_state : Enums.BattleState
var last_chosen_capacity : Move
var time_spent_in_state : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    last_state = Enums.BattleState.ENTER_BATTLE
    current_state = Enums.BattleState.ENTER_BATTLE
    Signals.ui_character_choses.connect(_on_character_chosen)
    Signals.ui_creature_choses.connect(_on_creature_chosen)
    Signals.resolution_ended.connect(_on_resolution_ended)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    time_spent_in_state += delta
    if current_state != last_state :
        time_spent_in_state = 0
        last_state = current_state
    if current_state == Enums.BattleState.ENTER_BATTLE and time_spent_in_state > TIME_TO_PREPARE :
        current_state = Enums.BattleState.PLAYER_CHOOSES_CHARACTER_ACTION
    if current_state == Enums.BattleState.BATTLE_REPORT and time_spent_in_state > TIME_TO_PREPARE :
        current_state = Enums.BattleState.ENTER_BATTLE

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
        last_chosen_capacity = this_creature.creature.moves[value]
        current_state = Enums.BattleState.ACTIONS_RESOLUTION

func _on_resolution_ended() -> void :
    if current_state == Enums.BattleState.ACTIONS_RESOLUTION :
        var is_slower = this_creature.creature.speed < other_creature.creature.speed
        var other_capacity = other_creature.creature.moves[randi()%4]
        
        var first_to_play = this_creature.creature
        var second_to_play = other_creature.creature
        var first_capacity = last_chosen_capacity
        var second_capacity = other_capacity
        
        if is_slower :
            first_to_play = other_creature.creature
            second_to_play = this_creature.creature
            first_capacity = other_creature
            second_capacity = last_chosen_capacity
            
        _apply_move(first_capacity, first_to_play, second_to_play)
        
        current_state = Enums.BattleState.PLAYER_CHOOSES_CHARACTER_ACTION
        if this_creature.creature.health <= 0 or other_creature.creature.health <= 0 :
            current_state = Enums.BattleState.BATTLE_REPORT
        else :
            _apply_move(second_capacity, second_to_play, first_to_play)
            if this_creature.creature.health <= 0 or other_creature.creature.health <= 0 :
                current_state = Enums.BattleState.BATTLE_REPORT
            
            
            
func _apply_move(move : Move, from : Creature, to : Creature):
    # Healing
    from.health = min(from.temp_health, from.health + move.this_health_effect)
    
    # Damage
    # (ATT-DEF) / 10 en pourcent de dmg en plus
    var modifier = (from.attack - to.defense) / 10.0 + 1
    var dmg = -move.other_health_effect * modifier
    var erosion = max(0,int(ceil(dmg * ( 0.1 + move.erosion_bonus)))) #arrondi a 1
    to.health -= int(dmg)
    to.temp_health -= erosion
    
    # Altération
    BattleContainer.alteration += move.alteration_effect
    
    # Fruits
    BattleContainer.remaining_fruits -= move.collect_effect
    
