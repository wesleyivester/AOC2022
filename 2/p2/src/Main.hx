class Main {
	static function main() {
		var scoremap = [
			[1+3, 1+0, 1+6], 
			[2+6, 2+3, 2+0], 
			[3+0, 3+6, 3+3]
		];
		var map1 = [
			"A" => 0,
			"B" => 1,
			"C" => 2
		];
		var map2 = [
			"X" => 0,
			"Y" => 1,
			"Z" => 2,
		];
		var movemap = [
			[2, 0, 1], 
			[0, 1, 2], 
			[1, 2, 0]
		];
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");
		var score = 0;
		for(line in lines)
		{
			if(line.length > 0)
			{
				var chars = line.split(" ");
				var c1 = chars[0];
				var c2 = chars[1];
				var v1 = map1[c1];
				var v2 = map2[c2];
				var ym = movemap[v2][v1];
				score+=scoremap[ym][v1];
			}
		}
		trace(score);
	}
}
