class Main {
	static function main() 
	{
		var content = sys.io.File.getContent("../input");
		var counts = [];
			counts.resize(26);
		for(i in 0...26)
			counts[i] = 0;
		var check = [];
		var max_check = 14;
		var unique = 0;
		var start = 0;

    	for(i in 0...content.length)
		{
			var char = content.charCodeAt(i);
			if(char >= "a".code && char <= "z".code)
			{
				char -= "a".code;
				counts[char]++;
				if(counts[char] == 1) unique++;
				check.unshift(char);
				if(check.length > max_check)
				{
					var old = check.pop();
					counts[old]--;
					if(counts[old] == 0) unique--;
				}
				if(unique == max_check)
				{
					start = i;
					break;
				}
			}
		}
		trace(start + 1);
	}
}