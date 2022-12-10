import sys.io.File;

class Main {
	static var map = [];
	// udlr
	// 012
	// 345
	// 678
	static var moveMap = [
		[[-1, 1, 1], [0, 0, 3], [-1, 1, 3], [0, 0, 1]],
		[[0, 1, 1], [0, 0, 4], [0, 0, 0], [0, 0, 2]],
		[[1, 1, 1], [0, 0, 5], [0, 0, 1], [1, 1, 5]],
		[[0, 0, 0], [0, 0, 6], [-1, 0, 3], [0, 0, 4]],
		[[0, 0, 1], [0, 0, 7], [0, 0, 3], [0, 0, 5]],
		[[0, 0, 2], [0, 0, 8], [0, 0, 4], [1, 0, 5]],
		[[0, 0, 3], [-1, -1, 7], [-1, -1, 3], [0, 0, 7]],
		[[0, 0, 4], [0, -1, 7], [0, 0, 6], [0, 0, 8]],
		[[0, 0, 5], [1,  -1, 7], [0, 0, 7], [1, -1, 5]],
	];
	static var dirMap = ["U"=>0, "D" => 1, "L"=>2, "R"=>3];

	static function main() 
	{
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");

		var visited = ["0:0"];
		var x = 0;
		var y = 0;
		var head = 4;
		for(line in lines)
		{
			if(line.length > 0)
			{
				var chars = line.split(" ");
				var dir = chars[0];
				var steps = Std.parseInt(chars[1]);
				for(i in 0...steps)
				{
					var next = moveMap[head][dirMap[dir]];
					x+=next[0];
					y+=next[1];
					head = next[2];
					var str = Std.string(x) + ":" + Std.string(y);
					//trace(str + " " + head);
					if(visited.indexOf(str) == -1)
					{
						visited.push(str);
					}
				}
			}
		}
		trace(visited.length);
	}
}