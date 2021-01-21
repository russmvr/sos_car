import 'package:bloc_viper/bloc_viper.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void confirmationCode([phoneNumber,verificationId,forceResendingToken]) =>
      pushReplacement(Pages.confirmationCodePage(phoneNumber,verificationId,forceResendingToken).route());


}
