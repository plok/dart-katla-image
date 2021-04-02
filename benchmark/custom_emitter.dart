import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:intl/intl.dart';

class CustomEmitter implements ScoreEmitter {
  const CustomEmitter();

  @override
  void emit(String testName, double value) {
    var timeFormat = NumberFormat("####.00");

    print('$testName(RunTime): ${timeFormat.format(value/1000)} ms.');
  }
}