import 'dart:async';

import 'dart:math';

class TypewriterBloc {
  static const _keys = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final _charStreamController = StreamController<String>();
  final _rnd = Random();

  Stream<String> get chars => _charStreamController.stream;

  void monkeyType() {
    final char = _keys[_rnd.nextInt(36)];
    _charStreamController.add(char);
  }
}
