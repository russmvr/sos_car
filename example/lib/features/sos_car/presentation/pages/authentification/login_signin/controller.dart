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
    if(event is SignInPageEvent){
      yield SignInPageState();
    }
    if(event is LogInPageEvent){
      yield MainFirstScreenState();
    }
    if(event is PhoneSignUp){
      yield TestingMultiplyState(event.email);
    }
    if(event is ConfirmationPageEvent){
    }
    if(event is GoToTestPageEvent){
      router.confirmationCode(event.phoneNumber,event.verificationId, event.forceResendingToken, event.isLogin, event.email);
    }
    if(event is MainPageEvent){
      router.mainPage();
    }
    if(event is EmailAndPasswordSignUpEvent){
      yield EmailAndPasswordSignUpState();
    }
  }
}
