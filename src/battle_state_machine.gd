extends Node

const TIME_TO_PREPARE : float = 3.0
const TIME_PER_ACTION : float = 1.0
@onready var this_creature: Node3D = $"../World/ThisCreature"
@onready var other_creature: Node3D = $"../World/OtherCreature"

var action_state : Enums.ActionResolutionState
var current_state : Enums.BattleState
var last_state : Enums.BattleState
var last_chosen_capacity : Move
var other_capacity : Move
var time_spent_in_state : float
var time_showing_action : float
var players_resolved : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    last_state = Enums.BattleState.ENTER_BATTLE
    current_state = Enums.BattleState.ENTER_BATTLE
    Signals.ui_character_choses.connect(_on_character_chosen)
    Signals.ui_creature_choses.connect(_on_creature_chosen)

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
    
    if current_state == Enums.BattleState.ENTER_BATTLE :
        _process_enter_battle()
    if current_state == Enums.BattleState.ACTIONS_RESOLUTION :
        _process_resolution(delta)

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
        _enter_state(Enums.BattleState.ACTIONS_RESOLUTION)


func _enter_state(new_state : Enums.BattleState) -> void :
    _leave_state()
    current_state = new_state
    if new_state == Enums.BattleState.ACTIONS_RESOLUTION :
        var is_slower = this_creature.creature.speed < other_creature.creature.speed
        other_capacity = other_creature.creature.moves[randi()%4]
        if is_slower :
            action_state = Enums.ActionResolutionState.RESOLVING_OTHER_ACTION
        else :
            action_state = Enums.ActionResolutionState.RESOLVING_PLAYER_ACTION    
        
func _leave_state() -> void:
    if current_state == Enums.BattleState.ACTIONS_RESOLUTION:
        players_resolved = 0

func _process_enter_battle() -> void:
    this_creature.creature.health = this_creature.creature.base_health
    this_creature.creature.temp_health = this_creature.creature.base_health
    other_creature.creature.health = other_creature.creature.base_health
    other_creature.creature.temp_health = other_creature.creature.base_health
    this_creature.is_players = true

func _process_resolution(delta : float) -> void :
    
    if players_resolved > 0 :
        time_showing_action += delta
        if time_showing_action < TIME_PER_ACTION:
            return
        else :
            time_showing_action = 0
            if action_state == Enums.ActionResolutionState.RESOLVING_PLAYER_ACTION :
                action_state = Enums.ActionResolutionState.RESOLVING_OTHER_ACTION
            else :
                action_state = Enums.ActionResolutionState.RESOLVING_PLAYER_ACTION
           
    
    if players_resolved == 2 :
        _enter_state(Enums.BattleState.PLAYER_CHOOSES_CHARACTER_ACTION)
        return
    
    if action_state == Enums.ActionResolutionState.RESOLVING_PLAYER_ACTION :
        _apply_move(last_chosen_capacity, this_creature.creature, other_creature.creature)
        players_resolved += 1
    else :
        _apply_move(other_capacity, other_creature.creature, this_creature.creature)
        players_resolved += 1
      
            
            
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
    if from.health <= 0 or to.health <= 0 or BattleContainer.remaining_fruits <= 0 :
            current_state = Enums.BattleState.BATTLE_REPORT
