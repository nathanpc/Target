// Target.dart
// Target's main file (v0.1a)

#library("target");

#import("dart:io");


/** Target server. */
class Target {
  Map redirections;
  HttpRequest req;
  HttpResponse res;
  var serverCallback;
  File file;
  var respond;
  String basePath;
  
  /**
   * Initiate the server instance.
   */
  void createServer(String path, int port, [String location = "127.0.0.1"]) {
    var server = new HttpServer();
    server.listen(location, port);
    basePath = path;

    server.onRequest = (HttpRequest request, HttpResponse response) {
      req = request;
      res = response;
      
      /**
       * Respond dynamically, or not, to the request
       */
      respond = (String userRes, [int status = HttpStatus.OK]) {
        if (userRes == null) {
          // Respond normally
          if (redirections.containsKey("none")) {
            // Is called when the developer hasn't set any page redirections.
            if (request.path.endsWith("/")) {
              file = new File("${basePath}/${request.path}index.html");
            } else {
              file = new File("${basePath}/${request.path}");
            }
          } else if (redirections.containsKey(request.path)) {
            // Is called if the developer set any page redirections.
            if (redirections.containsKey(request.path)) {
              file = new File("${basePath}/${redirections[request.path]}");
            } else {
              if (request.path.endsWith("/")) {
                file = new File("${basePath}/${request.path}index.html");
              } else {
                file = new File("${basePath}/${request.path}");
              }
            }
          } else {
            // Is called if the developer set any page redirections and the user
            // requests a page that isn't included in the redirection.
            if (request.path.endsWith("/")) {
              file = new File("${basePath}/${request.path}index.html");
            } else {
              file = new File("${basePath}/${request.path}");
            }
          }

          file.exists((found) {
            if (found) {
              file.openInputStream().pipe(response.outputStream);
            } else {
              response.statusCode = HttpStatus.NOT_FOUND;
              response.outputStream.close();
            }
          });
        } else {
          // Respond what you want
          if (userRes == "error") {
            response.statusCode = status;
          } else {
            response.outputStream.writeString(userRes);
          }

          response.outputStream.close();
        }
        
      };
      
      /**
       * Executes the request/response stuff
       */
      serverCallback();
    };
  }
}