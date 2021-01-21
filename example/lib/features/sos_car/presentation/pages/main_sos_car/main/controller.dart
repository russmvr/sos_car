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
    initialEvent: StartEvent(),
    router: Router(),
    interactor: Interactor(),
  );

  Stream<State> mapEvent(event, currentState) async* {
    if(event is StartEvent){
      yield Loading();
      final AllUserInfoModel info = await interactor.getInfo();
      yield* eitherLoaded(info);
    }

    if(event is CarInfoPage){
      router.carInfoScreen(event.userInfo);
    }
    if(event is ProfileUserPageEvent){
      router.profileUserPage(event.info);
    }
    if(event is GetUserTestEvent){
      final AllUserInfoModel info = await interactor.getInfo();
      yield GetUserTestState(info);
    }
  }

  Stream<State> eitherLoaded(AllUserInfoModel info) async* {
    yield Loaded(info);
  }
}
