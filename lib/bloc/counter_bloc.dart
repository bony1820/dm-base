import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/counter_repository.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CounterRepository repository;

  CounterBloc({required this.repository}) : super(const CounterState.initial()) {
    on<LoadCounter>((event, emit) async {
      emit(const CounterState.loading());
      final res = await repository.fetch();
      res.fold((f) => emit(CounterState.error(f.message)), (count) => emit(CounterState.loaded(count)));
    });

    on<IncrementCounter>((event, emit) async {
      emit(const CounterState.loading());
      final res = await repository.increment();
      res.fold((f) => emit(CounterState.error(f.message)), (count) => emit(CounterState.loaded(count)));
    });
  }
}
