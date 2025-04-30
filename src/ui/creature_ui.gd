extends Node

@onready var creature_skin: TextureRect = $HBoxContainer/CreatureSkin
@onready var name_label: RichTextLabel = $HBoxContainer/PanelContainer/Data/Name
@onready var pv_label: RichTextLabel = $HBoxContainer/PanelContainer/Data/PV

@export var creature : Creature

func _ready() -> void:
    creature_skin.texture = creature.sprite
    name_label.text = creature.name

func _process(delta: float) -> void:
    pv_label.text = str(creature.health) + "/" + str(creature.base_health)
    
