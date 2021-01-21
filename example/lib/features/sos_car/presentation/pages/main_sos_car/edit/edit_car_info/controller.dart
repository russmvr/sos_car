import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/car.dart';
import 'interactor.dart';
import 'model.dart';
import 'router.dart';

class Controller extends XController<Event,State,Router, Interactor> {
  Controller()
      : super(
    'Counter',
    initialState: MainFirstScreenState(),
    router: Router(),
    interactor: Interactor(),
  );

  Stream<State> mapEvent(event, currentState) async* {
    if(event is CarPhotosPage){
      router.carPhotos(event.userInfo, event.carInfo);
    }
    if(event is UpdateCarInfoEvent){
      final CarSosCar carRes = await interactor.updateCarInfo(event.carNewInfo);
      AllUserInfoModel allInfo = AllUserInfoModel(
          userBasicInfo: event.infoAll.userBasicInfo,
          carBasicInfo: carRes,
          evacuatorBasicInfo: event.infoAll.evacuatorBasicInfo );
      router.profileUserPage(allInfo);
    }
  }
}
