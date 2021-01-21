
import 'package:example/features/sos_car/data/repository.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:flutter/cupertino.dart';

class Interactor{
  const Interactor._(
      {@required this.getInfo});

  // factory Interactor() {
  //   return Interactor._(getInfo: Repository.userData.getInfo());
  // }

  factory Interactor() => Interactor._(getInfo: () async {
    return await Repository.userData.getInfo();
  } );



  final Future<AllUserInfoModel> Function() getInfo;


  }


