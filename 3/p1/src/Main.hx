class Main {
	static function main() 
	{
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");
		var sum = 0;
		for(line in lines)
		{
			if(line.length > 0)
			{
				var size = Std.int(line.length / 2);
				var s1 = line.substr(0, size);
				var s2 = line.substr(size);
				var r = getRepeated(s1, s2);
				sum+=getScore(r);
			}
		}
		trace(sum);
	}

	static function getScore(c:Int):Int
	{
		if(c >= "a".code && c <= "z".code)
			return c - "a".code + 1;
		if(c >= "A".code && c <= "Z".code)
			return c - "A".code + 27;
		return 0;
	}

	static function getRepeated(s1:String, s2:String):Int
	{
		var m = new Map<Int, Bool>();
		for (i in 0...s1.length) 
		{
			var c = s1.charCodeAt(i);
			m[c] = true;
		}
		var repeatedChar = 0;
		for(i in 0...s2.length)
		{
			repeatedChar = s2.charCodeAt(i); 
			if(m.exists(repeatedChar))
				break;
		}
		return repeatedChar;
	}
}
