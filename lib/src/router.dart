part of '../bloc_viper.dart';

abstract class XRouter {
  x.BuildContext _context;
  x.BuildContext get context => _context;

  @x.protected
  Future<T> push<T>(x.Route route) => x.Navigator.push<T>(context, route);

  @x.protected
  Future<T> pushReplacement<T>(x.Route route) =>
      x.Navigator.pushReplacement(context, route);




  @x.protected
  void pop<T>() => x.Navigator.pop(context);
}
