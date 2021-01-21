import 'package:equatable/equatable.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/user_info.dart';

class UserSosCar<T> extends Equatable {
  final UserInfoSosCar userBasicInfo;
  final CarSosCar carBasicInfo;
  final T evacuatorBasicInfo;

  UserSosCar({this.userBasicInfo, this.carBasicInfo, this.evacuatorBasicInfo});

}




