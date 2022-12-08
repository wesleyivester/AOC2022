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
				var pairs = line.split(",");
				var v1 = pairs[0].split("-");
				var v2 = pairs[1].split("-");
				if(contains(Std.parseInt(v1[0]), Std.parseInt(v1[1]), 
					Std.parseInt(v2[0]), Std.parseInt(v2[1])))
					sum++;
			}
		}
		trace(sum);
	}

	static function contains(s1:Int, e1:Int, s2:Int, e2:Int):Bool
	{
		if(s1 >= s2 && e1 <= e2) return true;
		if(s2 >= s1 && e2 <= e1) return true;
		return false;
	}
}
