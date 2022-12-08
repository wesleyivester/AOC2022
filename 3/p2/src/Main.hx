class Main {
	static function main() 
	{
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");
		var sum = 0;
		var groupSize = 3;
		var curr = 0;
		var group = [];
		for(line in lines)
		{
			if(line.length > 0)
			{
				group.push(line);
				if(group.length == groupSize){
					sum+=processGroup(group);
					group.resize(0);
				}
			}
		}
		trace(sum);
	}

	static function processGroup(g:Array<String>):Int
	{
		var m1 = new Map<Int, Bool>();
		var m2 = new Map<Int, Bool>();
		var p = 0;
		for (i in 0...g[p].length) 
		{
			var c = g[p].charCodeAt(i);
			m1[c] = true;
		}
		p++;

		var start = p;
		var end = g.length - 1;
		for (x in start...end)
		{
			for (i in 0...g[p].length) 
			{
				var c = g[p].charCodeAt(i);
				if(m1.exists(c))
					m2[c] = true;
			}
			m1 = m2.copy();
			m2.clear();
			p++;
		}	

		for (i in 0...g[p].length) 
		{
			var c = g[p].charCodeAt(i);
			if(m1.exists(c))
				return getScore(c);
		}
		return 0;
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
