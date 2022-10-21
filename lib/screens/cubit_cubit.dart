import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cubit_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(Initial());
  static  CounterCubit get(context)=>BlocProvider.of(context);
  int counter=0;
  /* var counter = 0;*/

  increment() {
    counter++;
    emit(Increment());
  }

  decrement() {
    counter--;
    emit(Decrement());
  }
}
