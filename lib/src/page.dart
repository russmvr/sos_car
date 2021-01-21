part of '../bloc_viper.dart';

abstract class XPage extends x.StatefulWidget {
  const XPage({x.Key key}) : super(key: key);

  x.PageRoute<T> route<T>() =>
      x.MaterialPageRoute<T>(builder: (context) => this);

  @override
  XPageState createState();
}

abstract class XPageState<T extends XPage, XEvent, XState> extends x.State<T> {
  XPageState(XController controller) : _controller = controller;

  final XController _controller;

  @override
  @x.protected
  @x.mustCallSuper
  void initState() {
    if (_controller.router != null) {
      _controller.router._context = context;
    }
    super.initState();
  }

  @override
  @x.protected
  @x.mustCallSuper
  void dispose() {
    _controller._close();
    super.dispose();
  }

  @x.protected
  void addEvent(XEvent event) => _controller._addEvent(event);

  @x.protected
  x.Widget stateBuilder(
    x.Widget Function(XState state) builder, {
    x.Widget initialWidget,
    bool Function(XState state) condition,
  }) {
    x.Widget stateWidget = initialWidget ?? x.Container();
    return x.StreamBuilder(
      stream: _controller._subjectState?.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null &&
            (condition == null || condition(snapshot.data))) {
          stateWidget = builder(snapshot.data);
        }
        return stateWidget;
      },
    );
  }
}
