randomise();

var roomWidth = round(room_width/16);
var roomHeight = round(room_height/16);

var lay_id = layer_get_id("Tiles_1");
var map_id = layer_tilemap_get_id(lay_id);

for (var i = 0; i < roomWidth; i++){
	for (var j = 0; j < roomHeight; j++){
		var type = irandom_range(1, 127);
		tilemap_set(map_id, type, i, j);
	}
}