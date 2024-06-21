extends Resource

class_name Storage

static var names : Dictionary = {
	-1: "Nothing",
	1: "SUPPLIES",
	2: "SCRAP",
	3: "ELECTRONICS",
	4: "ENERGY",
}

enum {
	NOTHING = -1,
	SUPPLIES = 1,
	SCRAP = 2,
	ELECTRONICS = 3,
	ENERGY = 4
}

@export var storage: Dictionary = {
	SUPPLIES = 0,
	SCRAP = 0,
	ELECTRONICS = 0,
	ENERGY = 0,
}
	
func add_commodities(commodity: int, quantity: int) -> void:
	storage[commodity] += quantity

func remove_commodities(commodity: int, quantity:int) -> void:
	storage[commodity] -= quantity

func get_all_commodities() -> Dictionary:
	var results : Dictionary;
	for item in storage.keys():
		if storage[item] > 0:
			results[item] = storage[item];
	return results;

func get_commodity_quantity(commodity:int) -> int:
	return storage[commodity]
