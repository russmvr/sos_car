import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class CarPhotosPage extends Event{
  UserInfoSosCar userInfo;
  CarSosCar carInfo;

  CarPhotosPage(this.userInfo, this.carInfo);
}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
