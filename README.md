An image library using opencv as backend for Dart developers.

## Requirements

dart_katla_image requires to have the katla-image & katla-dart libraries in LD_LIBRARY_PATH (https://github.com/plok/katla). Which in turn depends on opencv 

A simple usage example:

```dart
import 'package:dart_katla_image/dart_katla_image.dart';

main() {
  var image = Image.read("lenna.png");
  expect(image.stride, equals(1536));

  var r = Image.create(image.size, channels: 1);
  var g = Image.create(image.size, channels: 1);
  var b = Image.create(image.size, channels: 1);

  try {
    image.splitSync([r, g, b]);

    // do something with the channels
  } finally {
    r.dispose();
    g.dispose();
    b.dispose();
    image.dispose();
  }
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/plok/dart-katla-image/issues
