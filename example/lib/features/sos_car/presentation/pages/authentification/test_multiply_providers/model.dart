abstract class Event {}

class GoToTestPageEvent extends Event {
  String phoneNumber;
  String verificationId;
  int forceResendingToken;
  GoToTestPageEvent(this.phoneNumber,this.verificationId, this.forceResendingToken);
}

class LogInPageEvent extends Event {}
class SignInPageEvent extends Event {} //регистрация
class DecreamentEvent extends Event {}
class SelfEvent extends Event {}
class ChangeThemeEvent extends Event {}
class ConfirmationPageEvent extends Event {}



abstract class State {}

class LogInPageState extends State{}
class SignInPageState extends State{}
class MainFirstScreenState extends State {}
class ConfirmationPageState extends State {}

