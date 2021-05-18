import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_navigator_event.dart';
part 'bloc_navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  NavigatorBloc() : super(NavigatorState([0]));

  @override
  Stream<NavigatorState> mapEventToState(
    NavigatorEvent event,
  ) async* {
   if (event is NavigatorEventPushPage){

     NavigatorEventPushPage pushPage = event as NavigatorEventPushPage;
     List<int> values;
     values= state.values;
     values.add(pushPage.value);
     print(values.toString());
     if(pushPage.parametro!=null){
       yield state.copyWith(values: values,parametro: pushPage.parametro);
     }else yield state.copyWith(values: values);

   }else if(event is NavigatorEventResetNavigator) {
     yield state.copyWith(values: [-1]);
   }else if (event is NavigatorEventGetBack){

     List<int> values = state.values;
     values.removeAt(values.length-1);
     yield state.copyWith(values: values);
   }
  }
}
