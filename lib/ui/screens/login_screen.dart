import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/login_store.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          final progressState = Provider.of<Login>(context).progressState;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$progressState'),
                TextButton(
                  onPressed: () {
                    Provider.of<Login>(context, listen: false).login();
                  },
                  child: const Text('Login'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
