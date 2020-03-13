import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

class TypewriterBloc {
  static const _keys = 'abcdefghijklmnopqrstuvwxyz0123456789';
  static const WAIT_FOR_TYPING_PAUSE = Duration(milliseconds: 500);

  final _charStreamController = StreamController<String>();
  final _rnd = Random();
  final buffer = <String>[];

  Stream<String> get chars => _charStreamController.stream;

  Observable<String> get charGroup => Observable(chars).map((c) {
        buffer.add(c);
        return c;
      }).debounce(WAIT_FOR_TYPING_PAUSE);

  void monkeyType() {
    final char = _keys[_rnd.nextInt(36)];
    _charStreamController.add(char);
  }
}
