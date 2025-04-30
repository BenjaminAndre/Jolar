extends Node

var remaining_fruits : int
var alteration : float #0 to 1

@onready var this_creature: Node2D = $World/ThisCreature
@onready var other_creature: Node2D = $World/OtherCreature

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    remaining_fruits = 20 # ref à WH40k
    alteration = 0.1
    this_creature.creature.health = this_creature.creature.base_health
    other_creature.creature.health = other_creature.creature.base_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
