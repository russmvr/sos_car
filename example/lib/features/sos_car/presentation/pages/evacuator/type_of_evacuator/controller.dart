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
    if(event is ManipulatorEvacuator){
      router.manipulatorEvacuator(event.userInfo, event.carInfo);
    }
    if(event is EasyEvacuator){
      router.easyEvacuator(event.userInfo, event.carInfo);
    }
    if(event is CargoEvacuator){
      router.cargoEvacuator(event.userInfo, event.carInfo);
    }

  }
}
