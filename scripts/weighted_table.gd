class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum = 0


func add_item(item, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight


func remove_item(item_to_remove):
	# this says give us all the items in the items array that is not equal to item_to_remove.
	items = items.filter(func (item): return item["item"] != item_to_remove)
	# we set the weight sum to 0
	weight_sum = 0 
	# iterate over all the new filtered items, then adding up all the weight into the weight_sum
	for item in items:
		weight_sum += item["weight"]


func pick_item(exclude: Array = []):
	var adjusted_items: Array[Dictionary] = items
	var adjusted_weight_sum = weight_sum
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		# we iterate over each item in the items array
		for item in items:
			#we're the key item that is stored in the object and cheking if that item is in the exclude array.
			if item["item"] in exclude:
				#contine means that it will just go to the next item in the loop
				#and will stop the excuction of that specfic item and continue down the array of items
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item["weight"]
		
	
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
