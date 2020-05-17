extends HTTPRequest

signal finished
signal error

const ENDPOINT = "http://jeronimoschreyer.me/slot-server/public/"
var request_id = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func send(action, parameters=[]):
	request_id = request_id + 1
	parameters.push_back({"id": request_id})
	action = action + "?"
	for i in range(parameters.size()):
		action = action + parameters[i].keys()[0] + "=" + String(parameters[i].values()[0]) + "&"
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
