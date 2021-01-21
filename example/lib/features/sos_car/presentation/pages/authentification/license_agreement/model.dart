import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class CarInfoPage extends Event{
  UserInfoSosCar userInfo;
  CarInfoPage(userInfo);
}
class MainPageEvent extends Event{}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
