import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thespot/data/provider/auth_provider_impl.dart';
import 'package:thespot/repository/auth_repository_impl.dart';
import 'package:thespot/repository/google_sign_in_repository_impl.dart';
import 'package:thespot/store/auth_store.dart';
import 'package:thespot/ui/routes/routes.dart';

void main() {
  runApp(const TheSpotApp());
}

class TheSpotApp extends StatelessWidget {
  const TheSpotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthStore(
        signInRepository: GoogleSignInRepositoryImpl(),
        authRepository: AuthRepositoryImpl(provider: AuthProviderImpl()),
      ),
      child: MaterialApp(
        title: 'The Spot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: TheSpotRouter.generateRoute,
        initialRoute: TheSpotRouter.AUTH_ROUTE,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
