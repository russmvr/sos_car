import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void carInfoScreen(userInfo) => pushReplacement(Pages.carInfoPage(userInfo).route());
  void logInPageFromUserInfo() => pushReplacement(Pages.counterPage.route());
//  void testScreen() => pushReplacement(Pages.testPage1.route());
//  void signUpScreen() => pushReplacement();

//  void confirmationCode([verificationId,forceResendingToken]) =>
//      pushReplacement(Pages.confirmationCodePage(verificationId,forceResendingToken).route());
}
