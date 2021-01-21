import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/data/repository.dart';
import 'package:example/features/sos_car/models/evacuator.dart';

class Interactor{
  const Interactor._(
      {@required this.updateEvacInfo});

  factory Interactor() => Interactor._(updateEvacInfo: (evac) async {
    return await Repository.userData.updateEvacuatorInfo(evac);
  } );



  final Future<Evacuator> Function(Evacuator evac) updateEvacInfo;


}