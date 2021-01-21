import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void goToEditPage(AllUserInfoModel allInfo) => push(Pages.editPage(allInfo).route());
  void carInfoScreen(UserInfoSosCar userInfo) => pushReplacement(Pages.carInfoPage(userInfo).route());
  void mainPage() => pushReplacement(Pages.afterLogPage().route());

//  void testScreen() => pushReplacement(Pages.testPage1.route());
//  void signUpScreen() => pushReplacement();

//  void confirmationCode([verificationId,forceResendingToken]) =>
//      pushReplacement(Pages.confirmationCodePage(verificationId,forceResendingToken).route());
}
