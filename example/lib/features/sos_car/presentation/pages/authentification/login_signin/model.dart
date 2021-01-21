abstract class Event {}

class GoToTestPageEvent extends Event {
  String email;
  String phoneNumber;
  String verificationId;
  int forceResendingToken;
  bool isLogin;
  GoToTestPageEvent({this.phoneNumber,this.verificationId, this.forceResendingToken, this.isLogin, this.email});
}

class LogInPageEvent extends Event {}
class SignInPageEvent extends Event {} //регистрация
class SelfEvent extends Event {}
class EmailAndPasswordSignUpEvent extends Event {}
class ConfirmationPageEvent extends Event {}
class PhoneSignUp extends Event{
  String email;

  PhoneSignUp(this.email);
}
class MainPageEvent extends Event{}



abstract class State {}
class TestingMultiplyState extends State{
  String email;

  TestingMultiplyState(this.email);
}
class LogInPageState extends State{}
class SignInPageState extends State{}
class MainFirstScreenState extends State {}
class ConfirmationPageState extends State {}
class EmailAndPasswordSignUpState extends State{}

