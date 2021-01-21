import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/presentation/pages/authentification/car_info_adding/page.dart';


import 'interactor.dart';
import 'model.dart';
import 'router.dart';

class Controller
    extends XController<Event,State,Router, Interactor> {
  Controller()
      : super(
    'Counter',
    router: Router(),
  );

  Stream<State> mapEvent(event, currentState,) async* {
    if(event is InfoUserScreenEvent){
      router.infoUser(event.phoneNumber, event.code, event.email);
    }
    if(event is PageAfterEvent){
      router.pageAfter();
    }
  }
}
