part of 'bloc_navigator_bloc.dart';

class NavigatorState extends Equatable {
  final List<int> values;
  final int valuesLength;

  NavigatorState(this.values,{this.valuesLength});

  @override
  List<Object> get props => [values,valuesLength];

  NavigatorState copyWith({List<int> values}){
    return NavigatorState(
      values ?? this.values,
      valuesLength: values == null ? 0:values.length,
    );
  }
}
