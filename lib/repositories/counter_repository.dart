import 'package:dartz/dartz.dart';

class Failure {
  final String message;
  Failure(this.message);
}

abstract class CounterRepository {
  Future<Either<Failure, int>> fetchInitialCount();
  Future<Either<Failure, int>> increment(int current);
}

class CounterRepositoryImpl implements CounterRepository {
  int _count = 0;

  @override
  Future<Either<Failure, int>> fetchInitialCount() async {
    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 200));
    return Right(_count);
  }

  @override
  Future<Either<Failure, int>> increment(int current) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _count = current + 1;
    return Right(_count);
  }
}
