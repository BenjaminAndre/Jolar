extends Node

var creature_1 : Creature
var creature_2 : Creature

var remaining_fruits : int
var alteration : float #0 to 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    remaining_fruits = 20 # ref à WH40k
    alteration = 10
