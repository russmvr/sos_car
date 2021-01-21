import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import '../../pages.dart';


class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void carInfoScreen(UserInfoSosCar userInfo) => pushReplacement(Pages.carInfoPage(userInfo).route());

  void easyEvacuator(UserInfoSosCar userInfo, CarSosCar carInfo) =>
      pushReplacement(Pages.easyEvacuatorPage(userInfo, carInfo).route());

  void manipulatorEvacuator(UserInfoSosCar userInfo, CarSosCar carInfo) =>
      pushReplacement(Pages.manipulatorEvacuatorPage(userInfo, carInfo).route());

  void cargoEvacuator(UserInfoSosCar userInfo, CarSosCar carInfo) =>
      pushReplacement(Pages.cargoEvacuatorPaeg(userInfo, carInfo).route());

}
