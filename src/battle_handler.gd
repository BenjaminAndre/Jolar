extends Node


@onready var this_creature: Node= $World/ThisCreature
@onready var other_creature: Node = $World/OtherCreature

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    this_creature.creature.health = this_creature.creature.base_health
    this_creature.creature.temp_health = this_creature.creature.base_health
    other_creature.creature.health = other_creature.creature.base_health
    other_creature.creature.temp_health = other_creature.creature.base_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
