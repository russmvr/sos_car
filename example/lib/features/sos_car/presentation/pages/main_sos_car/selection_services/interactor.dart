
import 'package:example/features/sos_car/data/repository.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/services_provided.dart';
import 'package:flutter/cupertino.dart';

class Interactor{
  const Interactor._(
      {@required this.servicesInfo});

  factory Interactor() => Interactor._(servicesInfo: (serv) async {
    return await Repository.userData.setServices(serv);
  } );



  final Future<ServicesProvided> Function(ServicesProvided serv) servicesInfo;


}


