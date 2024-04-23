import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpin_demo/features/set_mpin/presentation/bloc/mpin/mpin_bloc.dart';
import 'package:mpin_demo/features/set_mpin/presentation/view/mpin_screen.dart';
import 'package:mpin_demo/injector.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(widget.title),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          )),
      body: Center(
        child: ElevatedButton(
          key: const Key('setMPIN_btn'),
          child: const Text(
            'Set MPIN',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(30, 60, 87, 1),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => BlocProvider.value(
                value: sl<MpinBloc>(),
                child: const MpinScreen(),
              ),
            ));
          },
        ),
      ),
    );
  }
}
