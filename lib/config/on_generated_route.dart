import 'package:flutter/material.dart';
import 'package:mpin_demo/config/page_constants.dart';
import 'package:mpin_demo/features/set_mpin/presentation/view/mpin_screen.dart';

final class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageConstants.homeScreen:
        return MaterialPageRoute(builder: (context) => const MpinScreen());
      case PageConstants.setMpinScreen:
        return MaterialPageRoute(builder: (context) => const MpinScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Page not found!"),
        ),
      );
    });
  }
}
