// simple_server.dart
// A very simple static server

#import("dart:io");
#import("../Target.dart");


void main() {
  var Target = new Target();
  
  Target.redirections = {
    "/test": "test.html",
    "/tindex": "test/index.html"
  };
  
  /*Target.redirections = {
    "none": ""
  };*/
  
  File script = new File(new Options().script);
  script.directory((Directory d) {
    Target.createServer(d.path + "/public", 8800);
    Target.serverCallback = () {
      // Just do your job Target...
      Target.respond(null);
    };
  });
}