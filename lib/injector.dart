import 'package:get_it/get_it.dart';
import 'package:mpin_demo/features/set_mpin/data/datasources/mpin_local_datasource.dart';
import 'package:mpin_demo/features/set_mpin/data/repositories/mpin_repository_imp.dart';
import 'package:mpin_demo/features/set_mpin/domain/usecases/mpinusecase.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton<MpinRepositoryImpl>(() => MpinRepositoryImpl(
        mPinLocalDataSource: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => MpinUseCase(
        repository: sl(),
      ));

  //DataSource
  sl.registerLazySingleton<MPinLocalDataSource>(() => MPinLocalDataSource(
        sharedPreferences: sl(),
      ));

  // Blocs
  sl.registerFactory(() => MpinBloc(
        getMpinUseCase: sl(),
      ));

  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPref);
}
