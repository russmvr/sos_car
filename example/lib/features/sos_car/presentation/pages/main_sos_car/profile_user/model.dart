

import 'dart:io';

import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/user_info.dart';

abstract class Event {}

class StartEvent extends Event{}

class MainPageEvent extends Event{}

class CarInfoPage extends Event{
  UserInfoSosCar userInfo;
  CarInfoPage(userInfo);
}


class GoToEditPage extends Event {
  AllUserInfoModel info;

  GoToEditPage(this.info);
}

class UpdateAvatarEvent extends Event {
  File avatar;

  UpdateAvatarEvent(this.avatar);
}

abstract class State {}


class SignInPageState extends State{}
class MainFirstScreenState extends State {}
class Loading extends State{}
class UpdateAvatarState extends State{

  final UserInfoSosCar info;

  UpdateAvatarState(this.info);
}

class StartState extends State{}
