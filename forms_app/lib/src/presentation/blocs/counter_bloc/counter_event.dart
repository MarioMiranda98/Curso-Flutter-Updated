part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();
}

class CounterIncreased extends CounterEvent {
  const CounterIncreased(this.value);

  final int value;

  @override
  List<Object?> get props => [];
}

class CounterReseted extends CounterEvent {
  const CounterReseted();

  @override
  List<Object?> get props => [];
}
