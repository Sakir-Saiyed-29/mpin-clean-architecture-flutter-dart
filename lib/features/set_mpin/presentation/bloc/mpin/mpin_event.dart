import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';

sealed class MpinEvent {
  const MpinEvent();
}

class LoadInitialMpinEvent extends MpinEvent {
  const LoadInitialMpinEvent();
}

class SetMpinEvent extends MpinEvent {
  final MpinEntity mpin;
  const SetMpinEvent(this.mpin);
}

class GetMpinEvent extends MpinEvent {
  const GetMpinEvent();
}
