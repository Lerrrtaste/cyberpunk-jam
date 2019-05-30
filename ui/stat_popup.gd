extends Control

func pop():
	match get_node("../").id:
		0: # exploit
			$PopUp.window_title = "Exploit"
			$PopUp/RichTextLabel.text = "The most basic of your utilities.\nDoesn't do anything but deals a good amount of damage if it reaches the computer."
		1: #packet sniffer
			$PopUp.window_title = "Packet Sniffer"
			$PopUp/RichTextLabel.text = "Reads all the packages flying around and uses the information to boost the HP of all Viruses in reach.\nDoes a little less damage to the computer."
		2: # ddos
			$PopUp.window_title = "DDos"
			$PopUp/RichTextLabel.text = "Regularly sends Denial of Service attacks to all Defenses in reach, disabling them for some time.\nDoes a little less damage to the computer."
		4: #brute force
			$PopUp.window_title = "Brute Force"
			$PopUp/RichTextLabel.text = "Best used along high damage and low HP viruses. It has so many HP, that it always gets targeted first.\nDoes very little damage to the computer."
		5: #worm
			$PopUp.window_title = "Worm"
			$PopUp/RichTextLabel.text = "The most advanced of your Viruses. Creates a clone of himself every now and then.\nDoes very little damage to the computer by himself.\nClones do a significantly high amount of damage."
		8: # keylogger
			$PopUp.window_title = "Keylogger"
			$PopUp/RichTextLabel.text = "Your main source of income. Generates money while alive but has almost no HP and does no damage to the computer."
	$PopUp/RichTextLabel.text += "\n\nHP:%s\nDamage to computer/s:%s"%[get_node("../").factory.troop_hp[get_node("../").id],get_node("../").factory.troop_compdmg[get_node("../").id]]
	$PopUp.popup_centered()