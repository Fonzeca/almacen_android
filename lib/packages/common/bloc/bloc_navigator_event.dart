part of 'bloc_navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent();
  @override
  List<Object> get props => [];
}

class NavigatorEventPushPage extends NavigatorEvent{
  final int value;
  NavigatorEventPushPage(this.value);
}
