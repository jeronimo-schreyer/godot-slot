extends TextureRect

signal anim_finished

var symbols = {
	"sym_a": [
		preload("res://arte/atlassym2.sprites/sym_a.tres"),
		preload("res://arte/atlassym2.sprites/sym_a_b.tres")
	],
	"sym_k": [
		preload("res://arte/atlassym2.sprites/sym_k.tres"),
		preload("res://arte/atlassym2.sprites/sym_k_b.tres")
	],
	"sym_q": [
		preload("res://arte/atlassym2.sprites/sym_q.tres"),
		preload("res://arte/atlassym2.sprites/sym_q_b.tres")
	],
	"sym_j": [
		preload("res://arte/atlassym2.sprites/sym_j.tres"),
		preload("res://arte/atlassym2.sprites/sym_j_b.tres")
	],
	"sym_10": [
		preload("res://arte/atlassym2.sprites/sym_10.tres"),
		preload("res://arte/atlassym2.sprites/sym_10_b.tres")
	],
	"sym_9": [
		preload("res://arte/atlassym2.sprites/sym_9.tres"),
		preload("res://arte/atlassym2.sprites/sym_9_b.tres")
	],
	"sym_p": [
		preload("res://arte/atlassym2.sprites/sym_placa.tres"),
		preload("res://arte/atlassym2.sprites/sym_placa_b.tres")
	],
	"sym_b": [
		preload("res://arte/atlassym2.sprites/sym_bonus.tres"),
		preload("res://arte/atlassym2.sprites/sym_bonus_b.tres")
	],
	"sym_g": [
		preload("res://arte/atlassym2.sprites/sym_girl.tres"),
		preload("res://arte/atlassym2.sprites/sym_girl_b.tres")
	],
	"sym_s": [
		preload("res://arte/atlassym2.sprites/sym_sherif.tres"),
		preload("res://arte/atlassym2.sprites/sym_sherif_b.tres")
	],
	"sym_c": [
		preload("res://arte/atlassym2.sprites/sym_cards.tres"),
		preload("res://arte/atlassym2.sprites/sym_cards_b.tres")
	],
	"sym_d": [
		preload("res://arte/atlassym2.sprites/sym_badguy.tres"),
		preload("res://arte/atlassym2.sprites/sym_badguy_b.tres")
	]
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_symbol(sym, blurred = false):
	if symbols.has(sym):
		var is_blurred = int(blurred)
		set_texture(symbols[sym][is_blurred])
	else:
		print("Symbol::update_symbol - '%s' symbol not found" % sym)

func animate(symbol_id):
	var anim_name = "sym_%s" % symbol_id
	if $AnimationPlayer.has_animation(anim_name):
		$AnimationPlayer.play(anim_name)
	else:
		$AnimationPlayer.play("sym_standard")
