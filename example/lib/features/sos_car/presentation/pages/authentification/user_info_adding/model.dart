import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class CarInfoPage extends Event{
  UserInfoSosCar userInfo1;
  CarInfoPage(this.userInfo1);
}

class LogInPageFromUserInfoEvent extends Event{}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
