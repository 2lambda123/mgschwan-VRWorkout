extends Spatial

var api

func _ready():
	api = get_tree().current_scene.get_node("HeartRateReceiver").vrhealthAPI
	api.connect("connect_app_initialized", self, "connect_vrhealth_complete")
	if api and api.isSetup():
		get_node("VRHealthPanel").print_info("VRHealth connection already setup\n\nPush all buttons to reconnect")
	else:
		get_node("VRHealthPanel").print_info("VRHealth not setup\n\nPush all buttons to connect")

func disable_all_connect_switches():
		get_node("VRHealthPanel/ConnectSwitch").set_state(false)
		get_node("VRHealthPanel/ConnectSwitch2").set_state(false)
		get_node("VRHealthPanel/ConnectSwitch3").set_state(false)
	
func connect_vrhealth_complete(onetime_code):
	get_node("VRHealthPanel").print_info("VRHealth connecting\n\nPress connect in the VRHealth app\nand enter the code\n\n %s"%onetime_code)
	if api:
		api.connectLive()
		
func connect_vrhealth():
	if api:
		api.connectApp(GameVariables.app_name)

func evaluate_connect_switches():
	var switch1 = get_node("VRHealthPanel/ConnectSwitch").value
	var switch2 = get_node("VRHealthPanel/ConnectSwitch2").value
	var switch3 = get_node("VRHealthPanel/ConnectSwitch3").value

	if switch1 and switch2 and switch3:
		connect_vrhealth()	
		disable_all_connect_switches()


func _on_ConnectSwitch_toggled(value):
	evaluate_connect_switches()
	yield(get_tree().create_timer(1.0), "timeout")
	disable_all_connect_switches()

func _on_ConnectSwitch2_toggled(value):
	evaluate_connect_switches()
	yield(get_tree().create_timer(1.0), "timeout")
	disable_all_connect_switches()

func _on_ConnectSwitch3_toggled(value):
	evaluate_connect_switches()
	yield(get_tree().create_timer(1.0), "timeout")
	disable_all_connect_switches()