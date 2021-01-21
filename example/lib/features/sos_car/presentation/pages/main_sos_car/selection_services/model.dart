import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/services_provided.dart';
import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class CarInfoPage extends Event{
  UserInfoSosCar userInfo;
  CarInfoPage(userInfo);
}

class GetUserTestEvent extends Event{}

class ProfileUserPageEvent extends Event{
  final AllUserInfoModel info;
  ProfileUserPageEvent(this.info);

}

class SelectableServicesEvent extends Event{
  AllUserInfoModel info;
  ServicesProvided services;

  SelectableServicesEvent(this.info,this.services);
}

class StartEvent extends Event{}


abstract class State {}

class StartPageState extends State{}

class Loading extends State{}

class Loaded extends State{
  final AllUserInfoModel info;

  Loaded(this.info);

}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}

class GetUserTestState extends State {
  final AllUserInfoModel info;

  GetUserTestState(this.info);
}
