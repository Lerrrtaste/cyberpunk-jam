extends Control

func pop():
	match get_node("../").id:
		0: # exploit
			$PopUp.window_title = "Exploit"
			$PopUp/RichTextLabel.text = "doesn nothing really"
		1: #packet sniffer
			$PopUp.window_title = "Packet Sniffer"
			$PopUp/RichTextLabel.text = "boosts maxhp of nearby allies"
		2: # ddos
			$PopUp.window_title = "DDos"
			$PopUp/RichTextLabel.text = "occasionally freezes enemy defenses for two seconds"
		4: #brute force
			$PopUp.window_title = "Brute Force"
			$PopUp/RichTextLabel.text = "has many hp and gets targeted first"
		5: #worm
			$PopUp.window_title = "Worm"
			$PopUp/RichTextLabel.text = "creates a clone of himself every now and then"
		8: # keylogger
			$PopUp.window_title = "Keylogger"
			$PopUp/RichTextLabel.text = "generates money in amounts not imaginable"
	$PopUp.popup(Rect2(400,400,100,100))