extends Node

# formats a number with thousand and decimal characters
static func price_format(value, thousand, decimal = ""):
	var number = str("%-3.2f" % value).replace(".", decimal)
	var last_position = number.find(decimal)
	
	if decimal.empty():
		number = str(floor(value))
		last_position = number.length()
	
	var i = last_position - 3
	while i > 0:
		number = number.insert(i, thousand)
		i = i - 3
	
	return number

#static func reparent_node(node, target):
#	var source = node.get_parent()
#	source.call_deferred("remove_child", node)
#	target.call_deferred("add_child", node)
#	node.call_deferred("set_owner", target)
