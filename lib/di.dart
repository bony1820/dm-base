import 'package:get_it/get_it.dart';
import 'repositories/counter_repository.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton<CounterRepository>(() => CounterRepositoryImpl());
}
