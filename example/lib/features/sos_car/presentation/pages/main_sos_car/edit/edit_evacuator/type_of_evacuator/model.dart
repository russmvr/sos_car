import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class ManipulatorEvacuator extends Event{
  AllUserInfoModel allInfo;
  ManipulatorEvacuator(this.allInfo);
}

class EasyEvacuator extends Event{
  AllUserInfoModel allInfo;
  EasyEvacuator(this.allInfo);
}

class CargoEvacuator extends Event{
  AllUserInfoModel allInfo;
  CargoEvacuator(this.allInfo);
}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
