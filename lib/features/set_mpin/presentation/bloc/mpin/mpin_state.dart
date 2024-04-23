import 'package:equatable/equatable.dart';
import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';

abstract class MpinState extends Equatable {}

class MpinInitialState extends MpinState {
  MpinInitialState();

  @override
  List<Object?> get props => [];
}

class MpinStateLoading extends MpinState {
  MpinStateLoading();
  @override
  List<Object?> get props => [];
}

class NewMpinLoadedSuccess extends MpinState {
  NewMpinLoadedSuccess();
  @override
  List<Object?> get props => [];
}

class MpinStateError extends MpinState {
  final String error;
  MpinStateError(this.error);
  @override
  List<Object?> get props => [error];
}

class MpinGetSuccessState extends MpinState {
  final List<MpinEntity> pins;
  MpinGetSuccessState({required this.pins});
  @override
  List<Object?> get props => [pins];
}
