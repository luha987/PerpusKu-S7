// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:tugas_uas/counter.dart';
import 'package:tugas_uas/main.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = Counter(MyApp);

    counter.increment();

    expect(counter.value, 1);
  });
}