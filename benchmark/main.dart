import 'dart:core';
import 'dart:io';
import 'katla_image_opencv_read.dart';
import 'katla_image_opencv_write.dart';
import 'katla_image_opencv_write_async.dart';
import 'package_image_read.dart';
import 'package_image_write.dart';
import 'katla_image_opencv_write_roi.dart';

void main() async {
  KatlaImageOpencvReadBenchmark.main();
  KatlaImageOpencvWriteBenchmark.main();
  await KatlaImageOpencvWriteAsyncBenchmark().report();
  KatlaImageOpencvRoiWriteBenchmark.main();
  PackageImageReadBenchmark.main();
  PackageImageWriteBenchmark.main();

  exit(0);
}