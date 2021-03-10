import 'dart:core';
import 'katla_image_opencv_read.dart';
import 'katla_image_opencv_write.dart';
import 'package_image_read.dart';
import 'package_image_write.dart';
import 'katla_image_opencv_write_roi.dart';

void main() {
  KatlaImageOpencvReadBenchmark.main();
  KatlaImageOpencvWriteBenchmark.main();
  KatlaImageOpencvRoiWriteBenchmark.main();
  PackageImageReadBenchmark.main();
  PackageImageWriteBenchmark.main();
}