import sys.io.File;

class Main {
	static var map = [];
	static var visible = [];
	static var mapW = 0;
	static var mapH = 0;

	static function main() 
	{
		var content = sys.io.File.getContent("../input");
		initMap(content);
		
		var maxScore = 0;
		for(y in 0...mapH)
		{
			for(x in 0...mapW)
			{
				var score = 
				distX(x, y, mapW, 1) *
				distX(x, y, -1, -1) *
				distY(x, y, mapH, 1) *
				distY(x, y, -1, -1);
				if(score > maxScore)
					maxScore = score;
			}
		}
		trace(maxScore);
	}

	static function distX(x:Int, y:Int, limit:Int, inc:Int):Int
	{
		var dist = 0;
		var cx = x + inc;
		if(cx == limit) return 0;
		var index = y * mapW + x;
		var height = map[index];
		while(cx != limit)
		{
			dist++;
			index = y * mapW + cx;
			if(map[index] >= height)
				break;
			cx+=inc;
		}	
		return dist;
	}

	static function distY(x:Int, y:Int, limit:Int, inc:Int):Int
	{
		var dist = 0;
		var cy = y + inc;
		if(cy == limit) return 0;
		var index = y * mapW + x;
		var height = map[index];
		while(cy != limit)
		{
			dist++;
			index = cy * mapW + x;
			if(map[index] >= height)
				break;
			cy+=inc;
		}	
		return dist;
	}

	static function initMap(content:String) 
	{
		for (i in 0...content.length)
		{
			var char = content.charCodeAt(i);
			if(char != "\n".code)
				map.push(char - "0".code);
			else if(mapW == 0)
				mapW = i;
		}
		mapH = Std.int(map.length / mapW);
		visible = [for (i in 0...map.length) 0];
	}
}