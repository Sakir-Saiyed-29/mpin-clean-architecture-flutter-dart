import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mpin_demo/features/set_mpin/data/datasources/mpin_local_datasource.dart';
import 'package:mpin_demo/features/set_mpin/data/repositories/mpin_repository_imp.dart';
import 'package:mpin_demo/features/set_mpin/domain/usecases/mpinusecase.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_bloc.dart';
import 'package:mpin_demo/features/set_mpin/presentation/view/homepage_screen.dart';
import 'package:mpin_demo/features/set_mpin/presentation/view/mpin_screen.dart';
import 'package:mpin_demo/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //late MpinBloc mpinBloc;
  group('homepage screen', () {
    SharedPreferences.setMockInitialValues({});
    setUpAll(() async {
      // Use cases
      sl.registerLazySingleton(() => MpinUseCase(
            repository: sl(),
          ));

      // Blocs
      sl.registerFactory(() => MpinBloc(
            getMpinUseCase: sl(),
          ));
      // Repository
      sl.registerLazySingleton<MpinRepositoryImpl>(() => MpinRepositoryImpl(
            mPinLocalDataSource: sl(),
          ));
      //DataSource
      sl.registerLazySingleton<MPinLocalDataSource>(() => MPinLocalDataSource(
            sharedPreferences: sl(),
          ));
      sl.registerSingleton<SharedPreferences>(
          await SharedPreferences.getInstance());
    });

    //setUp(() => {mpinBloc = sl<MpinBloc>()});

    testWidgets(':Render Home page', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: MyHomePage(
          title: 'MPIN Demo',
        ),
      ));

      var setMPINbtn = find.byType(ElevatedButton);
      expect(setMPINbtn, findsOneWidget);

      await tester.tap(setMPINbtn);
      await tester.pumpAndSettle();

      expect(find.byType(MpinScreen), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
