part of 'cubit_cubit.dart';

@immutable
abstract class CounterState {}

class Initial extends CounterState {}
class ChangeState extends CounterState {}
class Increment   extends CounterState{}
class Decrement extends CounterState {}

