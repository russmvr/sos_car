import 'package:flutter/cupertino.dart';

class AppSize {
  static height(BuildContext context) =>
      MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.vertical;

  static width(BuildContext context) =>
      MediaQuery.of(context).size.width -
          MediaQuery.of(context).padding.horizontal;

  static rHeight(BuildContext context) => height(context) / 667;

  static rWidth(BuildContext context) => width(context) / 375;
}