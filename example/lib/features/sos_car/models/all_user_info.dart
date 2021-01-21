import 'package:example/features/sos_car/models/services_provided.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:flutter/cupertino.dart';

import 'car.dart';
import 'evacuator.dart';

class AllUserInfoModel{
  final UserInfoSosCar userBasicInfo;
  final CarSosCar carBasicInfo;
  final Evacuator evacuatorBasicInfo;
  final ServicesProvided servicesInfo;

  AllUserInfoModel({
    this.userBasicInfo,
    this.carBasicInfo,
    this.evacuatorBasicInfo,
    this.servicesInfo});

}