import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';

abstract class MpinRepository {
  Future<List<MpinEntity>> getMpin();
  Future<void> setMpin(MpinEntity mpin);
}
