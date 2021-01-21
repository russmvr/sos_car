import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
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
    if(event is LicenseAgreement){
      router.licenseAgreement(event.allUserInfo);
    }
    if(event is UpdateEvacuatorEasyInfoEvent){
      final Evacuator evacRes = await interactor.updateEvacInfo(event.evacuatorNewInfo);
      AllUserInfoModel allInfo = AllUserInfoModel(
          servicesInfo: event.allUserInfo.servicesInfo,
          userBasicInfo: event.allUserInfo.userBasicInfo,
          carBasicInfo: event.allUserInfo.carBasicInfo,
          evacuatorBasicInfo: evacRes);
      router.profileUserPage(allInfo);
    }
  }
}
