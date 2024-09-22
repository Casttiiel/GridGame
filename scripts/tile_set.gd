extends TileMapLayer

var GridSizeY = 3
var GridSizeX = 3
var Dic = {}
var CoordenatesTiles = {}
var selectedTile

func _ready():
	for x in range(GridSizeX):
		for y in range(GridSizeY):
			Dic[str(Vector2(x, y))] = {
				"type": "Grass"
			}
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)
		set_cells_terrain_connect([Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(2, 1), Vector2i(2, 0), Vector2i(1, 0), Vector2i(1, 1)], 0, 0, true)
	
	for x in range(GridSizeX):
		for y in range(GridSizeY):
			Dic[str(Vector2(3 + x, y))] = {
				"type": "Stone"
			}
			set_cell(Vector2i(3 + x, y), 1, Vector2i(3, 0), 0)

func _process(delta):
	var tile = local_to_map(get_global_mouse_position())
	selectedTile = map_to_local(tile)
	if Dic.has(str(tile)):
		set_cell(tile, 1, Vector2i(0, 0), 0)
