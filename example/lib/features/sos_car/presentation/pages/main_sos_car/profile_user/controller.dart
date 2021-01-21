import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/user_info.dart';
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
    if(event is CarInfoPage){
      router.carInfoScreen(event.userInfo);
    }
    if(event is StartEvent){
      // final AllUserInfoModel info = await interactor.getInfo();
      yield* eitherLoadedStart();
    }
    if(event is GoToEditPage){
      router.goToEditPage(event.info);
    }
    if(event is UpdateAvatarEvent){
      yield Loading();
      final UserInfoSosCar info = await interactor.updateAvatar(event.avatar);
      yield* eitherLoadedUpdate(info);
    }
    if(event is MainPageEvent){
      router.mainPage();
    }
  }

  Stream<State> eitherLoadedStart() async* {
    yield StartState();
  }

  Stream<State> eitherLoadedUpdate(UserInfoSosCar info) async* {
    yield UpdateAvatarState(info);
  }

}
