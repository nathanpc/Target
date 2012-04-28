// callback_server.dart
// A more advanced server, this is where the magic happens

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
    // Don't just redirect, do what I want you to do!
    Target.createServer(d.path + "/public", 8800, (req, res) {
      print("${req.method}: ${req.path}");
      
      if (req.path == "/response_test") {
        // Respond with a HTML file.
        File hfile = new File("${Target.basePath}/test/resp.html");
        hfile.exists((found) {
          if (found) {
            hfile.readAsText(Encoding.UTF_8, (String text) {
              Target.respond(text);
            });
          } else {
            // If the file wasn't found return a 404.
            print("404");
            Target.respond("error", HttpStatus.NOT_FOUND);
          }
        });
      } else if (req.path == "/hello") {
        // Respond with your own generated HTML.
        Target.respond("<h1>Hello, World!</h1>");
      } else {
        // Just make a normal redirect.
        Target.respond(null);
      }
    });
  });
}