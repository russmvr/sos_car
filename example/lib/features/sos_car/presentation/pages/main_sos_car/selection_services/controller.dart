import 'package:bloc_viper/bloc_viper.dart';
import 'package:example/features/sos_car/models/all_user_info.dart';
import 'package:example/features/sos_car/models/evacuator.dart';
import 'package:example/features/sos_car/models/services_provided.dart';
import 'interactor.dart';
import 'model.dart';
import 'router.dart';

class Controller extends XController<Event, State, Router, Interactor> {
  Controller()
      : super(
          'Counter',
          initialEvent: StartEvent(),
          router: Router(),
          interactor: Interactor(),
        );

  Stream<State> mapEvent(event, currentState) async* {
    if (event is StartEvent) {
      yield* eitherLoaded();
    }

    if (event is CarInfoPage) {
      router.carInfoScreen(event.userInfo);
    }
    if (event is GetUserTestEvent) {}
    if (event is SelectableServicesEvent) {
      final ServicesProvided servRes =
          await interactor.servicesInfo(event.services);
      AllUserInfoModel allInfo = AllUserInfoModel(
          evacuatorBasicInfo: event.info.evacuatorBasicInfo,
          carBasicInfo: event.info.carBasicInfo,
          userBasicInfo: event.info.userBasicInfo,
          servicesInfo: servRes);
      router.profileUserPage(allInfo);
    }
  }

  Stream<State> eitherLoaded([AllUserInfoModel info]) async* {
    yield Loaded(info);
  }
}
