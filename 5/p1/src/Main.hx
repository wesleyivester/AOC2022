class Main {
	static var stacks:Array<Array<String>> = [];

	static function main() 
	{
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");
		var start = initStacks(lines);
		var movefmt = ~/move ([0-9]+) from ([0-9]+) to ([0-9]+)/;
		for (i in start...lines.length)
		{
			var line = lines[i];
			if(line.length > 0)
			{
				if(movefmt.match(line))
				{
					var amount = Std.parseInt(movefmt.matched(1));
					var from = Std.parseInt(movefmt.matched(2)) - 1;
					var to = Std.parseInt(movefmt.matched(3)) - 1;
					move(to, from, amount);
				}
				else {
					trace("match error");
				}
			}
		}
		readTops();
	}

	static function move(to:Int, from:Int, amount:Int)
	{
		trace("to: " + to + " from: " + from + " amount: " + amount);
		for(i in 0...amount)
		{
			if(stacks[from].length == 0)
			{
				trace("error stack is 0");
				break;
			}
			var val = stacks[from].pop();
			stacks[to].push(val);
		}
	}

	static function readTops()
	{
		var tops = "";
		for(stack in stacks)
		{
			if(stack.length > 0)
				tops+=stack[stack.length - 1];
		}
		trace(tops);
	}

	static function initStacks(lines:Array<String>):Int
	{
		var start = 0;
		for(line in lines)
		{
			if(line.length == 0)
			{
				break;
			}
			start++;
		}
		var l = start - 1;
		var stackCount = Std.int((lines[l].length + 1) / 4);
		stacks.resize(stackCount);
		for(i in 0...stacks.length)
			stacks[i] = [];
		trace("Stacks: " + stackCount);
		l--;
		while(l >= 0)
		{
			var line = lines[l];
			for(s in 0...stackCount)
			{
				var item = line.charAt(4 * s + 1);
				if(item != " ")
					stacks[s].push(item);
			}
			l--;
		}
		return start + 1;
	}
}