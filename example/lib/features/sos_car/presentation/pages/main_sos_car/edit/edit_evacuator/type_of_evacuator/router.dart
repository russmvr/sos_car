import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import '../../../../pages.dart';




class Router extends XRouter {
  void counter() => push(Pages.counterPage.route());
  void carInfoScreen(UserInfoSosCar userInfo) => pushReplacement(Pages.carInfoPage(userInfo).route());

  void easyEvacuator(AllUserInfoModel allInfo) =>
      pushReplacement(Pages.easyEvacuatorEditPage(allInfo).route());

  void manipulatorEvacuator(AllUserInfoModel allInfo) =>
      pushReplacement(Pages.manipulatorEvacuatorEditPage(allInfo).route());

  void cargoEvacuator(AllUserInfoModel allInfo) =>
      pushReplacement(Pages.cargoEvacuatorEditPage(allInfo).route());

}
