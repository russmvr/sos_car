import 'dart:io';

import 'package:example/core/params/empty_params.dart';
import 'package:example/features/sos_car/data/api.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/services_provided.dart';
import 'package:example/features/sos_car/models/user_info.dart';
import 'package:flutter/cupertino.dart';

class Repository{
  static _ProfileData get userData => _ProfileData();

}

class _ProfileData {
  Future<AllUserInfoModel> getInfo() async {
    AllUserInfoModel info = await Api.getInfoProfile();
    return info;
  }

  Future<UserInfoSosCar> updateAvatar(File newAvatar) async{
    UserInfoSosCar result = await Api.updateAvatar(newAvatar);
    return result;
  }

  Future<CarSosCar> updateCarInfo(CarSosCar carNewInfo) async{
    CarSosCar info = await Api.updateInfoCar(carNewInfo);
    return info;
  }

  Future<Evacuator> updateEvacuatorInfo(Evacuator evacNewInfo) async{
    Evacuator info = await Api.updateInfoEvacuator(evacNewInfo);
    return info;
  }

  Future<ServicesProvided> setServices(ServicesProvided serv) async{
    ServicesProvided info = await Api.setServices(serv);
    return info;
  }
}