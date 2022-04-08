import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:thespot/data/model/auth_employee.dart';
import 'package:thespot/data/provider/auth/auth_provider.dart';
import 'package:thespot/data/provider/reservation/reservation_provider.dart';
import 'package:thespot/repository/auth/auth_repository.dart';
import 'package:thespot/repository/auth/google_sign_in_repository.dart';
import 'package:thespot/repository/reservation/reservation_repository.dart';
import 'package:thespot/store/auth/auth_store.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_store.dart';
import 'package:thespot/ui/routes/routes.dart';

void main() {
  GetIt.I.registerSingleton<AuthEmployee>(AuthEmployee.initial());
  runApp(const TheSpotApp());
}

class TheSpotApp extends StatelessWidget {
  const TheSpotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthStore(
            ssoRepository: GoogleSignInRepository(),
            authRepository: AuthRepository(provider: AuthProvider()),
          ),
        ),
        Provider(
          create: (context) => ReserveOrQueryStore(
            repository: ReservationRepository(provider: ReservationProvider()),
          ),
        ),
      ],
      builder: (context, _) => MaterialApp(
        title: 'The Spot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: TheSpotRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
