import 'package:bloc_viper/bloc_viper.dart';
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
    if(event is TypeOfEvacuator){
      router.typeOfEvacuator(event.userInfo,event.carInfo);
    }
    if(event is LicenseAgreement){
      router.licenseAgreement(event.allUserInfo);
    }
  }
}
