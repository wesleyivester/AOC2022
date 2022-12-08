import haxe.ds.List;
import sys.io.File;

class Main {
  static function main() {
    var content = sys.io.File.getContent("../input");

    var maxes = new List<Int>();
    var max_maxes = 3;
    var max = 0;
    var current = 0;
    var lines = content.split("\n");
    for(line in lines)
    {
      if(line.length == 0)
      {
        if(current >= max)
        {
          max = current;
          trace(max);
          maxes.add(max);
          if(maxes.length > max_maxes)
            maxes.pop();
        }
        current = 0;
      }
      else
      {
        current+=Std.parseInt(line);
      }
    }
    var maxes_sum = 0;
    for(m in maxes)
    {
      trace(m);
      maxes_sum += m;
    }
    trace(maxes_sum);
  }
}