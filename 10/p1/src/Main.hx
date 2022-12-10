import eval.luv.Stream;
import sys.io.File;

class Main {
	static var instMap = [
		"noop"=>0, "addx"=>1
	];
	static var X:Int;
	static var cycleCount:Int;
	static var screenW = 40;
	static var screenH = 6;
	static var screen:Array<String> = [];

	static function output()
	{
		var str = "";
		for(s in 0...screen.length)
		{
			if(s%screenW==0)
				str+="\n";
			str+=screen[s];
		}
		writeFile("../output", str, true);
	}

	static function writeFile(filename:String, content:String, clear = false)
	{
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

		X = 1;
		cycleCount = 0;
		screen.resize(screenW * screenH);
		for(i in 0...screen.length)
			screen[i] = ".";

		for(line in lines)
		{
			if(line.length > 0)
			{
				var s = line.split(" ");
				var inst = instMap[s[0]];
				switch (inst)
				{
					case 0:
						cycle(1);
					case 1:
						cycle(2);
						X += Std.parseInt(s[1]);
				}
			}
		}
		output();
	}

	static function cycle(count:Int)
	{
		for(c in 0...count)
		{
			for(x in X-1...X+2)
			{
				var beamX = cycleCount % screenW;
				var beamY = Std.int(cycleCount / screenW) % screenH;
				if(x == beamX)
				{
					screen[beamY * screenW + beamX] = "#";
				}
			}
			cycleCount++;
		}
	}
}