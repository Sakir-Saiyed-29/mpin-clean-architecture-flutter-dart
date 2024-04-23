import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpin_demo/config/app_themes.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_bloc.dart';
import 'package:mpin_demo/features/set_mpin/presentation/view/homepage_screen.dart';
import 'package:mpin_demo/injector.dart';
import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: BlocProvider(
        create: (context) => sl<MpinBloc>(),
        child: const MyHomePage(
          title: 'MPIN Demo',
        ),
      ),
    );
  }
}
