import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void typeOfEvacuator(UserInfoSosCar userInfo, CarSosCar carInfo) =>
      pushReplacement(Pages.typeEvacuatorPage(userInfo, carInfo).route());
  void licenseAgreement(UserSosCar allUserInfo) =>
      pushReplacement(Pages.licenseAgreementPageFromShowDialog(allUserInfo).route());
}
