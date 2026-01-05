import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';
import '../repositories/counter_repository.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CounterRepository repository;

  CounterBloc({required this.repository}) : super(CounterInitial()) {
    on<LoadCounter>(_onLoad);
    on<IncrementCounter>(_onIncrement);
  }

  Future<void> _onLoad(LoadCounter event, Emitter<CounterState> emit) async {
    emit(CounterLoading());
    final res = await repository.fetchInitialCount();
    res.fold((failure) => emit(CounterError(failure.message)), (value) => emit(CounterLoaded(value)));
  }

  Future<void> _onIncrement(IncrementCounter event, Emitter<CounterState> emit) async {
    final current = state is CounterLoaded ? (state as CounterLoaded).count : 0;
    emit(CounterLoading());
    final res = await repository.increment(current);
    res.fold((failure) => emit(CounterError(failure.message)), (value) => emit(CounterLoaded(value)));
  }
}
