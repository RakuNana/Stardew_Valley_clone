extends Node

#delete this script?

func test(tilemap):
	
	for x in tilemap:
		#gettile map, check soil and seeded?
		print(x)

func get_plant_data(all_planted):
	
#	for x in all_planted.get_child_count():
	for x in all_planted.get_child_count():
		all_planted.get_child(x).plus_day()
		
		#print(all_planted.get_child(x).days_planted, " " , all_planted.get_child(x).name)
