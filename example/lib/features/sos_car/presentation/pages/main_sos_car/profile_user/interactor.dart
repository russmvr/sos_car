import 'dart:io';

import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/data/repository.dart';
import 'package:example/features/sos_car/models/user_info.dart';

class Interactor{
  const Interactor._(
      {@required this.updateAvatar});

  factory Interactor() => Interactor._(updateAvatar: (avatar) async {
    return await Repository.userData.updateAvatar(avatar);
  } );



  final Future<UserInfoSosCar> Function(File avatar) updateAvatar;


}