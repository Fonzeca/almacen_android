part of 'bloc_navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent();
  @override
  List<Object> get props => [];
}

class NavigatorEventPushPage extends NavigatorEvent{
  final int value;
  final Object parametro;
  NavigatorEventPushPage(this.value,{this.parametro});
}

class NavigatorEventResetNavigator extends NavigatorEvent{
  NavigatorEventResetNavigator();
}

class NavigatorEventGetBack extends NavigatorEvent{

}

