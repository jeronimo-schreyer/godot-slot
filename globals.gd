extends Node

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
