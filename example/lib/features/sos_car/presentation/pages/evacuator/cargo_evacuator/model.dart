import 'package:example/features/sos_car/models/user_info.dart';
import 'package:example/features/sos_car/models/user_sos_car.dart';

abstract class Event {}

class LicenseAgreement extends Event{
  UserSosCar allUserInfo;
  LicenseAgreement(this.allUserInfo);
}

abstract class State {}

class SignInPageState extends State{}
class MainFirstScreenState extends State {}
