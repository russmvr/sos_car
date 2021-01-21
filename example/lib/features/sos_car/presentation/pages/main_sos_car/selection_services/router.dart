import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void carInfoScreen(UserInfoSosCar userInfo) => pushReplacement(Pages.carInfoPage(userInfo).route());
  void profileUserPage(AllUserInfoModel info) => pushReplacement(Pages.profileUserPage(info).route());

// void profileUserPage() => push(Pages.profileUserPage().route());
//  void testScreen() => pushReplacement(Pages.testPage1.route());
//  void signUpScreen() => pushReplacement();

//  void confirmationCode([verificationId,forceResendingToken]) =>
//      pushReplacement(Pages.confirmationCodePage(verificationId,forceResendingToken).route());
}
