import 'dart:async';

class SearchTimer {
  static Timer timer = Timer(Duration.zero, () {});

  static final SearchTimer _singleton = SearchTimer._internal();
  factory SearchTimer(Function() callback) {
    timer.cancel();
    timer = Timer(const Duration(seconds: 1), callback);

    return _singleton;
  }
  SearchTimer._internal();
}
