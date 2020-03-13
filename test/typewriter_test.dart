import 'package:quiver/testing/async.dart';
import 'package:test/test.dart';
import 'package:testing_times/src/typewriter.dart';

void main() {
  group('Test the typewriter', () {
    TypewriterBloc typewriter;

    setUp(() {
      typewriter = TypewriterBloc();
    });

    // This test will fail because of async and microtasks
    // test('get a char when monkey types', () {
    //   String char;
    //   typewriter.chars.listen((event) {
    //     char = event;
    //   });
    //   typewriter.monkeyType();
    //   expect(char, isNotNull);
    // });

    test('get a char when monkey types (with time travel)', () {
      FakeAsync().run((async) {
        String char;
        typewriter.chars.listen((event) {
          char = event;
        });
        typewriter.monkeyType();

        // now need to flush to get Stream to emit
        async.flushMicrotasks();
        expect(char, isNotNull);
      });
    });

    test('get a set of chars when monkey pauses typing', () {
      FakeAsync().run((async) {
        String stanza;
        typewriter.charGroup.listen((event) {
          stanza = event;
        });
        typewriter.monkeyType();
        typewriter.monkeyType();
        typewriter.monkeyType();

        //fast forward time to after the required pause
        async.elapse(TypewriterBloc.WAIT_FOR_TYPING_PAUSE);

        expect(stanza, isNotNull);
        expect(typewriter.buffer.length, 3);
      });
    });
  });
}
