// main.dart
// Main test file, this is where the magic happens

#import("dart:io");
#import("../Target.dart");


void main() {
  print("Hello World");
  
  File script = new File(new Options().script);
  script.directory((Directory d) {
    Target.createServer(d.path, "127.0.0.1", 8800);
  });
}
