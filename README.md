# Target

Dart's easy, simple and fast web server.


## Examples

If you look at the `tests` folder you'll have all the debug codes I made to test
the features of the server. Anyhow, here is how you create a simple server:

```
#import("dart:io");
#import("Target.dart");


void main() {
  var Target = new Target();

  Target.redirections = {
    "none": ""
  };
  
  File script = new File(new Options().script);
  script.directory((Directory d) {
    Target.createServer(d.path + "/public", 8800);
    Target.serverCallback = () {
      // Just do your job Target...
      Target.respond(null);
    };
  });
}
```

If you want to create a more advanced server where you want to handle requests and respond to them dynamically you just need to implement the `serverCallback()` with a `respond()`, like this:

```
// Same as the simple server, but...

Target.createServer(d.path + "/public", 8800);

// Don't just redirect, do what I want you to do!
Target.serverCallback = () {
  print("From the server test script: ${Target.req.path}");
  
  if (Target.req.path == "/response_test") {
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
  } else if (Target.req.path == "/hello") {
    // Respond with your own generated HTML.
    Target.respond("<h1>Hello, World!</h1>");
  } else {
    // Just make a normal redirect.
    Target.respond(null);
  }
};

// Close the rest of the calls.
```

I recommend you to check out the [**Wiki**][1] for more information, help and learn more about page redirections and other cool things.

## Changelog

**v0.02a**

  * Added support for page redirections

**v0.01a**

  * First working code
  * Just a static server
  * Redirects `{path}/` to `{path}/index.html`


[1]: https://github.com/nathanpc/Target/wiki