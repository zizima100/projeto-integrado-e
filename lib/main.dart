import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/login_store.dart';
import 'package:thespot/ui/screens/login_screen.dart';
import 'package:thespot/repository/google_sign_in_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Login(GoogleSignInRepositoryImpl()),
      child: MaterialApp(
        title: 'The Spot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
