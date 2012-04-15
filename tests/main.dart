// main.dart
// Main test file, this is where the magic happens

#import("dart:io");
#import("../Target.dart");


void main() {
  var Target = new Target();
  
  File script = new File(new Options().script);
  script.directory((Directory d) {
    Target.createServer(d.path + "/public", 8800);
  });
}
