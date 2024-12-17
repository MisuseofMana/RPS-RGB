extends Node2D

@onready var anims = $AnimationPlayer

func _on_area_2d_area_entered(area):
	anims.play('break')

func _on_animation_player_animation_finished(anim_name):
	queue_free()
