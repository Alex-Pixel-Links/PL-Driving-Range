extends TileMap

const BucketGreen = preload("res://Objects/Bucket_Green.tscn")
const BucketBrown = preload("res://Objects/Bucket_Brown.tscn")
const BucketTan = preload("res://Objects/Bucket_Tan.tscn")

func _ready():
	var GreenBucket = get_used_cells_by_id(9)
	var BrownBucket = get_used_cells_by_id(8)
	var TanBucket = get_used_cells_by_id(7)
	
	replaceGreenBucket(GreenBucket)
	replaceBrownBucket(BrownBucket)
	replaceTanBucket(TanBucket)

func replaceGreenBucket(tileArr):
	var GreenBucketPos
	for i in range(0, tileArr.size()):
		var newGreenBucket = BucketGreen.instance()
		GreenBucketPos = map_to_world(tileArr[i]) + cell_size
		newGreenBucket.set_position(GreenBucketPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newGreenBucket)
		
func replaceBrownBucket(tileArr):
	var BrownBucketPos
	for i in range(0, tileArr.size()):
		var newBrownBucket = BucketBrown.instance()
		BrownBucketPos = map_to_world(tileArr[i]) + cell_size
		newBrownBucket.set_position(BrownBucketPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newBrownBucket)
	
func replaceTanBucket(tileArr):
	var TanBucketPos
	for i in range(0, tileArr.size()):
		var newTanBucket = BucketTan.instance()
		TanBucketPos = map_to_world(tileArr[i]) + cell_size
		newTanBucket.set_position(TanBucketPos)
		set_cell(tileArr[i].x,tileArr[i].y, -1)
		self.add_child(newTanBucket)
