abstract class Event {}

class InfoUserScreenEvent extends Event{
  String phoneNumber;
  final code;
  String email;

  InfoUserScreenEvent({this.phoneNumber, this.code, this.email});
}
class PageAfterEvent extends Event{}


abstract class State {}
