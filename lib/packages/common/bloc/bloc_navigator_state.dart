part of 'bloc_navigator_bloc.dart';

class NavigatorState extends Equatable {
  final List<int> values;

  NavigatorState([this.values]);

  @override
  List<Object> get props => [values];

  NavigatorState copyWith({List<int> values}){
    return NavigatorState(
      values ?? this.values,
    );
  }
}
