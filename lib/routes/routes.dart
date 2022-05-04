// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:thespot/routes/route_arguments.dart';
import 'package:thespot/ui/screens/auth_screen.dart';
import 'package:thespot/ui/screens/confirmation_screen.dart';
import 'package:thespot/ui/screens/reserve_or_query_screen.dart';

class TheSpotRouter {
  static Route<dynamic> _defaultRoute(String text) => MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text(text)),
        ),
      );

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTH_ROUTE:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case RESERVE_OR_QUERY_ROUTE:
        return MaterialPageRoute(builder: (_) => const ReserveOrQueryScreen());
      case CONFIRMATION_ROUTE:
        if (settings.arguments is ConfirmationScreenArguments) {
          final argument = settings.arguments as ConfirmationScreenArguments;
          return MaterialPageRoute(
            builder: (_) => ConfirmationScreen(
              onNoTap: argument.onNoTap,
              onYesTap: argument.onYesTap,
              text: argument.text,
            ),
          );
        }
        return _defaultRoute('No arguments defined for $CONFIRMATION_ROUTE');
      default:
        return _defaultRoute('No route defined for ${settings.name}');
    }
  }

  static const AUTH_ROUTE = '/';
  static const RESERVE_OR_QUERY_ROUTE = '/main';
  static const CONFIRMATION_ROUTE = '/confirmation';
}
