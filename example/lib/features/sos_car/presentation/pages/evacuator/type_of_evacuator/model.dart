import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class ManipulatorEvacuator extends Event{
  UserInfoSosCar userInfo;
  CarSosCar carInfo;
  ManipulatorEvacuator(this.userInfo, this.carInfo);
}

class EasyEvacuator extends Event{
  UserInfoSosCar userInfo;
  CarSosCar carInfo;
  EasyEvacuator(this.userInfo, this.carInfo);
}

class CargoEvacuator extends Event{
  UserInfoSosCar userInfo;
  CarSosCar carInfo;
  CargoEvacuator(this.userInfo, this.carInfo);
}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
