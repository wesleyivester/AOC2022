import sys.io.File;

class Main {
  static function main() {
    var content = sys.io.File.getContent("../input");

    var max = 0;
    var current = 0;
    var lines = content.split("\n");
    for(line in lines)
    {
      if(line.length == 0)
      {
        current = 0;
      }
      else
      {
        current+=Std.parseInt(line);
        if(current > max) max = current;
      }
    }
    trace(max);
  }
}