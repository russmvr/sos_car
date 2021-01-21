import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';

abstract class Event {}

class LicenseAgreement extends Event{
  UserSosCar allUserInfo;
  LicenseAgreement(this.allUserInfo);
}

class UpdateEvacuatorManipulatorInfoEvent extends Event{
  AllUserInfoModel allUserInfo;
  Evacuator evacuatorNewInfo;

  UpdateEvacuatorManipulatorInfoEvent(this.allUserInfo, this.evacuatorNewInfo);
}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
