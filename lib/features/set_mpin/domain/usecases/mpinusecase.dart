import 'package:mpin_demo/features/set_mpin/data/repositories/mpin_repository_imp.dart';
import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';
import 'package:mpin_demo/features/set_mpin/domain/repositoryInterfaces/mpin_repository.dart';

class MpinUseCase implements MpinRepository {
  final MpinRepositoryImpl repository;

  MpinUseCase({required this.repository});

  @override
  Future<List<MpinEntity>> getMpin() {
    return repository.getMpin();
  }

  @override
  Future<void> setMpin(MpinEntity mpin) async {
    return repository.setMpin(mpin);
  }
}
