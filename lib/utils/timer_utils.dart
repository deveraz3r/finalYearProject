import 'dart:async';

class TimerUtils {
  Timer? _timer;
  int _seconds = 59;

  /// Starts the countdown timer
  void startTimer(Function(int) onTick, Function onComplete) {
    _seconds = 59;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds--;
      onTick(_seconds);
      if (_seconds <= 0) {
        _timer?.cancel();
        onComplete();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}
