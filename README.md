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
  });
}
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