part of '../bloc_viper.dart';

abstract class XPageLight<XEvent> extends x.StatelessWidget {
  const XPageLight(XController controller, {x.Key key})
      : _controller = controller,
        super(key: key);

  x.PageRoute<T> route<T>() => x.MaterialPageRoute(builder: (context) => this);

  final XController _controller;

  @x.protected
  void addEvent(XEvent event) => _controller._addEvent(event);

  @override
  @x.protected
  @x.mustCallSuper
  x.Widget build(x.BuildContext context) {
    if (_controller.router != null) {
      _controller.router._context = context;
    }
    throw UnimplementedError();
  }
}
