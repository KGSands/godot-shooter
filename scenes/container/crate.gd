extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		for i in range(randi()%6):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos , current_direction)
		opened = true
