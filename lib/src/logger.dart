part of '../bloc_viper.dart';

class XLogger {
  const XLogger._(this.name);

  final String name;

  void info(String info) => print('$name: $info');

  static void setMessages(
    String startMessage,
    String Function(dynamic event) eventMessage,
    String Function(dynamic state) stateMessage,
    String closeMessage,
  ) {
    _startMessage = startMessage ?? _startMessage;
    _eventMessage = eventMessage ?? _eventMessage;
    _stateMessage = stateMessage ?? _stateMessage;
    _closeMessage = closeMessage ?? _closeMessage;
  }

  static String _startMessage = 'start';
  static String Function(dynamic event) _eventMessage =
      (event) => event.toString();
  static String Function(dynamic state) _stateMessage =
      (state) => state.toString();
  static String _closeMessage = 'close';
}
