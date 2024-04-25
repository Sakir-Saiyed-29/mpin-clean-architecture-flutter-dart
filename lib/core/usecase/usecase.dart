import 'package:dartz/dartz.dart';
import 'package:mpin_demo/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
