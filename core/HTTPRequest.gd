extends HTTPRequest

signal finished
signal error

const ENDPOINT = "http://jeronimoschreyer.me/slot-server/public/"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func send(action, parameters=[]):
	if parameters.size() > 0:
		action = action + "?"
		for i in range(parameters.size()):
			action = action + parameters[i].keys()[0] + "=" + parameters[i].values()[0] + "&"
		action = action.substr(0, action.length() - 1)
	request(ENDPOINT + action)
	return self

func handler(result, response_code, headers, body):
	var json
	match response_code:
		200:
			json = JSON.parse(body.get_string_from_utf8())
			emit_signal("finished", json)
		_:
			emit_signal("error", response_code)
