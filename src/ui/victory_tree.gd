extends Control


@onready var fruits: RichTextLabel = $Data/Fruits
@onready var alteration: RichTextLabel = $Data/Alteration


func _process(delta: float) -> void:
    fruits.text = "Fruits : " + str(BattleContainer.remaining_fruits)
    alteration.text = "Altération : " + str(int(BattleContainer.alteration * 100)) + " %"
    
