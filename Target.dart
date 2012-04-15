// Target.dart
// Target's main file

#library("target");

#import("dart:io");

class Target {
  void createServer(String basePath, String location, int port) {
    var server = new HttpServer();
    server.listen(location, port);

    server.onRequest = (HttpRequest request, HttpResponse response) {
      print(request.path.toString());
      print(basePath);
    };
  }
}