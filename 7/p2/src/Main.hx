class File {
	public function new(name, parent, isDir) {
		this.name = name;
		this.parent = parent;
		this.isDir = isDir;
	}
	public var isDir = false;
	public var parent = -1;
	public var name = "";
	public var size = 0;
	public var children = new Map<String, Int>();
	public var enumerated = false;
}

class Main {
	static var files = [new File("/", -1, true)];

	static function main() 
	{
		var content = sys.io.File.getContent("../input");
    	var lines = content.split("\n");
		loadFiles(lines);
		updateDirSizes(false);
		updateDirSizes(true);
		trace(smallest(70000000, 30000000));
	}

	static function smallest(total_space:Int, required_space:Int):Int
	{
		var used = files[0].size;
		var needed = required_space - (total_space - used);
		var smallest = total_space;
		for(file in files)
		{
			if(file.isDir && file.size >= needed && file.size < smallest)
				smallest = file.size;
		}
		return smallest;
	}

	static  function check()
	{
		var sum = 0;
		var i = 0;
		for(file in files)
		{
			if(!file.isDir && Lambda.count(file.children) > 0)
				trace("Error 1");
			if(file.isDir)
			{
				for (k=>v in file.children)
				{
					if(files[v].parent != i)
						trace("Error i");
				}
			}
			i++;
		}
	}

	static  function findSize(dir:Bool) 
	{
		var sum = 0;
		for(file in files)
		{
			if(file.isDir == dir)
				sum += file.size;
			if(file.isDir && !file.enumerated)
				trace("not enumerated");
		}
		return sum;
	}

	static function sumAtMost(max:Int):Int
	{
		var sum = 0;
		for(file in files)
		{
			if(file.isDir && file.size <= max)
				sum += file.size;
		}
		return sum;
	}

	static function updateDirSizes(dir:Bool) 
	{
		for(file in files)
		{
			if(file.isDir == dir && file.parent != -1)
			{
				if(dir)
				{
					var parent = file.parent;
					while(parent != -1)
					{
						files[parent].size += file.size;
						parent = files[parent].parent;
					}
				}
				else
					files[file.parent].size += file.size;
			}
		}
	}

	static function loadFiles(lines:Array<String>)
	{
		var dirPos = [0];
		var skip = false;
		var fileCount = 0;
		var dirCount = 0;
		var fileSize = 0;
		for(line in lines)
		{
			if(line.length > 0)
			{
				//trace(line);
				var curr = dirPos[dirPos.length - 1];
				if (line.charAt(0) == "$")
				{
					var split = line.split(" ");
					if(split[1] == "cd")
					{
						var dirname = split[2];
						if(dirname == "..")
							dirPos.pop();
						else if (dirname == "/")
							dirPos.resize(1);
						else
						{
							var file = files[curr];
							var childId = file.children[dirname];
							if(!files[childId].isDir)
								trace("Error: pushing non-dir");
							dirPos.push(childId);
						}
					}
					else if(split[1] == "ls")
					{
						var file = files[curr];
						skip = file.enumerated;
						file.enumerated = true;
					}
				}
				else
				{
					if(!skip)
					{
						var split = line.split(" ");
						var file = files[curr];
						var name = "";
						if(split[0] == "dir")
						{
							name = split[1];
							files.push(new File(split[1], curr, true));
							dirCount++;
						}
						else 
						{
							name = split[1];
							var file = new File(split[1], curr, false);
							file.size = Std.parseInt(split[0]);
							files.push(file);
							fileCount++;
							fileSize+=file.size;
						}
						if(file.children.exists(name))
							trace("Error: exists");
						file.children[name] = files.length - 1;
					}
				}
			}
		}
		trace("FileCount: " + fileCount);
		trace("DirCount: " + dirCount);
		trace("FileSize: " + fileSize);
		trace(files.length);
	}
}