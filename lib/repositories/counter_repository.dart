import 'dart:async';

import 'package:dartz/dartz.dart';

class Failure {
  final String message;
  Failure(this.message);
}

abstract class CounterRepository {
  Future<Either<Failure, int>> fetch();
  Future<Either<Failure, int>> increment();
}

class CounterRepositoryImpl implements CounterRepository {
  int _count = 0;

  @override
  Future<Either<Failure, int>> fetch() async {
    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 300));
    return right(_count);
  }

  @override
  Future<Either<Failure, int>> increment() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _count++;
    return right(_count);
  }
}
