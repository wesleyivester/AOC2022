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
		writeFile("../omap", true);
		writeFile("../o1");
		scanX(0, mapW, 1);
		writeFile("../o2");
		scanX(mapW - 1, -1, -1);
		writeFile("../o3");
		scanY(0, mapH, 1);
		writeFile("../o4");
		scanY(mapH - 1, -1, -1);
		writeFile("../o5");
		var totalVisible = countVisible();
		trace(totalVisible);
	}

	static function writeFile(filename:String, mapFile = false)
	{
		var file = File.write(filename);

		var i = 0;
		for(y in 0...mapH)
		{
			for(x in 0...mapW)
			{
				if(mapFile)
					file.writeByte(map[i] + "0".code);
				else
					file.writeByte(visible[i] + "0".code);
				i++;
			}
			file.writeByte("\n".code);
		}
		file.close();
	}

	static function countVisible():Int 
	{
		var sum = 0;
		for(v in visible)
		{
			if(v > 0)
				sum++;
		}
		return sum;
	}

	static function scanY(start:Int, end:Int, dy:Int)
	{
		var highest = 0;
		var y = 0;
		var index = 0;
		for(x in 0...mapW)
		{
			y = start;
			highest = -1;
			while (y != end)
			{
				index = y * mapW + x;
				if(map[index] > highest)
				{
					if(visible[index] == 2)	// if already visible from y direction
						break;
					visible[index] = 2;	// visible from y direction
					highest = map[index];
					if(highest == 9)	// nothing higher than this
						break;
				}
				y+=dy;
			}
		}
	}

	static function scanX(start:Int, end:Int, dx:Int)
	{
		var highest = 0;
		var x = 0;
		var index = 0;
		for(y in 0...mapH)
		{
			x = start;
			highest = -1;
			while (x != end)
			{
				index = y * mapW + x;
				if(map[index] > highest)
				{
					if(visible[index] == 1)	// if already visible from x direction
						break;
					visible[index] = 1;	// visible from x direction
					highest = map[index];
					if(highest == 9)	// nothing higher than this
						break;
				}
				x+=dx;
			}
		}
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