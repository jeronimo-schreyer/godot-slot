extends TextureRect

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
		preload("res://arte/atlassym2.sprites/sym_badguy.tres"),
		preload("res://arte/atlassym2.sprites/sym_badguy_b.tres")
	]
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_symbol(sym, blurred = false):
	if symbols.has(sym):
		set_texture(symbols[sym][int(blurred)])
	else:
		print("Symbol::update_symbol - '%s' symbol not found" % sym)
