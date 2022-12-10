import sys.io.File;

class PrintSettings 
{
	public function new(w, h, ox, oy) {
		this.w = w;
		this.h = h;
		this.ox = ox;
		this.oy = oy;
	}
	public var w:Int = 0;	// width
	public var h = 0;		// height
	public var ox = 0;		// offset x
	public var oy = 0;		// offset y
}

class Main {
	static var map = [];
	// u,d,l,r,ul,ur,dl,dr
	// 012
	// 345
	// 678
	// keeps track of the next segment.
	// row: if next segment is at position [0-8]
	// col: and segment moves in direction [0-7]
	// this segment should move in: (only needed to track tail position)
	// x: moveMap[next][dir][0]
	// y: moveMap[next][dir][1]
	// and now the next segment is at position [0-8]
	static var moveMap = [
		[[-1, 1, 1], [0, 0, 3],   [-1, 1, 3],  [0, 0, 1],  [-1, 1, 0], [0, 1, 1], [-1, 0, 3],  [0, 0, 4]],
		[[0, 1, 1],  [0, 0, 4],   [0, 0, 0],   [0, 0, 2],  [-1, 1, 1], [1, 1, 1], [0, 0, 3],   [0, 0, 5]],
		[[1, 1, 1],  [0, 0, 5],   [0, 0, 1],   [1, 1, 5],  [0, 1, 1],  [1, 1, 2], [0, 0, 4],   [1, 0, 5]],
		[[0, 0, 0],  [0, 0, 6],   [-1, 0, 3],  [0, 0, 4],  [-1, 1, 3], [0, 0, 1], [-1, -1, 3], [0, 0, 7]],
		[[0, 0, 1],  [0, 0, 7],   [0, 0, 3],   [0, 0, 5],  [0, 0, 0], [0, 0, 2], [0, 0, 6],   [0, 0, 8]],
		[[0, 0, 2],  [0, 0, 8],   [0, 0, 4],   [1, 0, 5],  [0, 0, 1],  [1, 1, 5], [0, 0, 7],   [1, -1, 5]],
		[[0, 0, 3],  [-1, -1, 7], [-1, -1, 3], [0, 0, 7],  [-1, 0, 3], [0, 0, 4], [-1, -1, 6], [0, -1, 7]],
		[[0, 0, 4],  [0, -1, 7],  [0, 0, 6],   [0, 0, 8],  [0, 0, 3],  [0, 0, 5], [-1, -1, 7], [1, -1, 7]],
		[[0, 0, 5],  [1,  -1, 7], [0, 0, 7],   [1, -1, 5], [0, 0, 4],  [1, 0, 5], [0, -1, 7],  [1, -1, 8]],
	];
	static var dirMap = ["U"=>0, "D" => 1, "L"=>2, "R"=>3];
	static var dirMap2 = [4, 0, 5, 2, -1, 3, 6, 1, 7];
	static var output = true;

	static function directionDir(x:Int, y:Int):Int
	{
		// 405
		// 2 3
		// 617
		return dirMap2[(1 - y) * 3 + x + 1];
	}

	static function dirname(dir:Int):String 
	{
		var names = ["Up", "Down", "Left", "Right", "UpLeft", "UpRight", "DownLeft", "DownRight"];
		return names[dir];	
	}

	static function print(ps:PrintSettings, heads:Array<Int>, x:Int, y:Int, visited:Array<String>):String
	{
		if(!output) return "";
		var dx = [-1, 0, 1, -1, 0, 1, -1, 0, 1];
		var dy = [1, 1, 1, 0, 0, 0, -1, -1, -1];
		x+=ps.ox;
		y+=ps.oy;
		var print:Array<Array<String>> = [];
		print.resize(ps.h);
		for(yi in 0...ps.h)
		{
			print[yi] = [];
			print[yi].resize(ps.w);
			for(xi in 0...ps.w)
			{
				print[yi][xi] = ".";
			}
		}

		for(coord in visited)
		{
			var coords = coord.split(":");
			var cx = Std.parseInt(coords[0]) + ps.ox;
			var cy = Std.parseInt(coords[1]) + ps.oy;
			print[cy][cx] = "#";
		}

		print[ps.oy][ps.ox] = "s";
		print[y][x] = "9";
		for(i in 0...heads.length)
		{
			var head = heads[heads.length - i - 1];
			x+=dx[head];
			y+=dy[head];
			print[y][x] = String.fromCharCode((9-i-1)+"0".code);
		}
		print[y][x] = "H";

		var str = "";
		for(yi in 0...ps.h)
		{
			for(xi in 0...ps.w)
			{
				str += print[ps.h-1-yi][xi];
			}
			str+="\n";
		}
		return str;
	}

	static function writeFile(filename:String, content:String, clear = false)
	{
		if(!output) return;
		var file;
		if(clear)
			file = File.write(filename);
		else
			file = File.append(filename);
		file.writeString(content);
		if(content.charAt(content.length - 1) != "\n")
			file.writeString("\n");
		file.close();
	}

	static function main() 
	{
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");

		var ropeLength = 10;
		//var ps = new PrintSettings(26, 21, 11, 5); // input2
		var ps = new PrintSettings(150, 80, 90, 70); // input2

		var visited = ["0:0"];
		var x = 0;
		var y = 0;
		var head = []; // where this segment is in relation to the previous (0-head, end-just before tail)
		for(i in 0...ropeLength-1)
			head.push(4);
		writeFile("../output", print(ps, head, x, y, visited), true);
		for(line in lines)
		{
			if(line.length > 0)
			{
				var chars = line.split(" ");
				var dir = chars[0];
				var steps = Std.parseInt(chars[1]);
				writeFile("../output", line);
				for(i in 0...steps)
				{
					var nextDir = dirMap[dir];
					var nextMove = [];
					writeFile("../output", "H moves: " + dirname(nextDir));
					for(h in 0...head.length)
					{
						nextMove = moveMap[head[h]][nextDir];
						head[h] = nextMove[2];
						nextDir = directionDir(nextMove[0], nextMove[1]);
						if(nextDir == -1)	// if this segment isn't moving, none of the following will either
							break;
						writeFile("../output", String.fromCharCode(h + 1 + "0".code) + " moves: " + dirname(nextDir));
					}
					x+=nextMove[0];
					y+=nextMove[1];
					var str = Std.string(x) + ":" + Std.string(y);
					if(visited.indexOf(str) == -1)
					{
						visited.push(str);
					}
				}
				writeFile("../output", print(ps, head, x, y, visited));
			}
		}
		trace(visited.length);
	}
}