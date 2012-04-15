// Target.dart
// Target's main file

#library("target");

#import("dart:io");


/** Target server. */
class Target {
  /**
   * Initiate the server instance.
   */
  void createServer(String basePath, int port, [String location = "127.0.0.1"]) {
    var server = new HttpServer();
    server.listen(location, port);

    server.onRequest = (HttpRequest request, HttpResponse response) {
      print(request.path);
      print("\n==================\n");

      var file;

      if (request.path.endsWith("/")) {
        file = new File("${basePath}/${request.path}index.html");
      } else {
        file = new File("${basePath}/${request.path}");
      }

      file.exists((found) {
        if (found) {
          file.openInputStream().pipe(response.outputStream);
        } else {
          response.statusCode = HttpStatus.NOT_FOUND;
          response.outputStream.close();
        }
      });
    };
  }
}