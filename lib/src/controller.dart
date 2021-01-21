part of '../bloc_viper.dart';

abstract class XController<XEvent, XState, XXRouter extends XRouter, XInteractor>
{
  XController(
    String logger,{
    XState initialState,
    this.router,
    this.interactor,
    XEvent initialEvent,
  })  : _logger = XLogger._(logger),
        _subjectState = (XState != Null) ? BehaviorSubject<XState>() : null {
    _logger.info(XLogger._startMessage);
    if (initialState != null) {
      _logger.info(XLogger._stateMessage(initialState));
      _currentState = initialState;
      _subjectState.sink.add(initialState);
    }
    if (initialEvent != null) {
      _addEvent(initialEvent);
    }
  }

  final XLogger _logger;
  final XXRouter router;
  final XInteractor interactor;
  XState _currentState;
  final BehaviorSubject<XState> _subjectState;

  @x.protected
  Stream<XState> mapEvent(
    XEvent event,
    XState currentState,
  );

  void _addEvent(XEvent event) {
    _logger.info(XLogger._eventMessage(event));
    mapEvent(event, _currentState).forEach((state) {
      if (_subjectState != null) {
        _logger.info(XLogger._stateMessage(state));
        _currentState = state;
        _subjectState.sink.add(state);
      }
    });
  }

  void _close() {
    _logger.info(XLogger._closeMessage);
    if (_subjectState != null) {
      _subjectState.close();
    }
  }
}
