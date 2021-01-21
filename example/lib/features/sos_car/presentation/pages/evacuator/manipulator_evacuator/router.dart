import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void carInfoScreen(UserInfoSosCar userInfo) => pushReplacement(Pages.carInfoPage(userInfo).route());
  void licenseAgreement(UserSosCar allUserInfo) => pushReplacement(Pages.licenseAgreementPageFromAnyEvacuator(allUserInfo).route());
}
