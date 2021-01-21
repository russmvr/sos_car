import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/data/repository.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';

class Interactor{
  const Interactor._(
      {@required this.updateCarInfo});

  factory Interactor() => Interactor._(updateCarInfo: (car) async {
    return await Repository.userData.updateCarInfo(car);
  } );



  final Future<CarSosCar> Function(CarSosCar car) updateCarInfo;


}