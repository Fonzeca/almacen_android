import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_navigator_event.dart';
part 'bloc_navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  NavigatorBloc() : super(NavigatorState());

  @override
  Stream<NavigatorState> mapEventToState(
    NavigatorEvent event,
  ) async* {
   if (event is NavigatorEventPushPage){
     NavigatorEventPushPage pushPage = event as NavigatorEventPushPage;
     List<int> values = state.values;
     values.add(pushPage.value);
     yield state.copyWith(values: values);
   }
  }
}
