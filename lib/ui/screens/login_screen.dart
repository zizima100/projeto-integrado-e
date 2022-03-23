import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/login_store.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final progressState = Provider.of<Login>(context).progressState;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SvgPicture.asset(
                'assets/logo.svg',
                fit: BoxFit.contain,
                height: context.layoutHeight(7.5),
              ),
              SizedBox(
                height: context.layoutHeight(4),
              ),
              const _GoogleSignInButton(),
              SizedBox(
                height: context.layoutHeight(4.5),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  'assets/chair.svg',
                  fit: BoxFit.contain,
                  height: context.layoutHeight(55),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.layoutHeight(0.5)),
            ),
          ),
        ),
        onPressed: () async {
          await Provider.of<Login>(context, listen: false).login();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.layoutHeight(1.8)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/google_logo.svg',
                fit: BoxFit.contain,
                height: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Login with Google',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
