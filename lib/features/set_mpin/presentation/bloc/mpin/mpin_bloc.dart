import 'package:flutter/widgets.dart';
import 'package:mpin_demo/features/set_mpin/domain/entities/mpin_entity.dart';
import 'package:mpin_demo/features/set_mpin/domain/usecases/mpinusecase.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_event.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MpinBloc extends Bloc<MpinEvent, MpinState> {
  final MpinUseCase getMpinUseCase;

  MpinBloc({required this.getMpinUseCase}) : super(MpinInitialState()) {
    on<LoadInitialMpinEvent>((event, emit) async {
      //Implement an event handler
      debugPrint('Bloc loadmpin called..');
      List<MpinEntity> pins = await getMpinUseCase.getMpin();
      emit(MpinGetSuccessState(pins: pins));
    });
    on<SetMpinEvent>((event, emit) async {
      //Implement an event handler
      debugPrint('Bloc setMpin called..');
      getMpinUseCase.setMpin(event.mpin);
      emit(NewMpinLoadedSuccess());
    });
    on<GetMpinEvent>((event, emit) async {
      //Implement an event handler
      debugPrint('Bloc getMpin called..');
      List<MpinEntity> pins = await getMpinUseCase.getMpin();
      emit(MpinGetSuccessState(pins: pins));
    });
  }
}
