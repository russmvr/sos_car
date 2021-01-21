import 'package:bloc_viper/bloc_viper.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void infoUser(idUser, code, email) => pushReplacement(Pages.infoUserPage(idUser, code, email).route());
  void pageAfter() => pushReplacement(Pages.afterLogPage().route());

//  void testScreen() => pushReplacement(Pages.testPage1.route());
//  void signUpScreen() => pushReplacement();
}
