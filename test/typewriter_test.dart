import 'package:quiver/testing/async.dart';
import 'package:test/test.dart';
import 'package:testing_times/src/typewriter.dart';

void main() {
  group('Test the typewriter', () {
    TypewriterBloc typewriter;

    setUp(() {
      typewriter = TypewriterBloc();
    });

    test('get a char when monkey types', () {
      String char;
      typewriter.chars.listen((event) {
        char = event;
      });
      typewriter.monkeyType();
      expect(char, isNotNull);
    });
  });
}
