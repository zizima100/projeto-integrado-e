import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/auth_state.dart';
import 'package:thespot/store/auth_store.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';
import 'package:thespot/ui/routes/routes.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var progressState = context.watch<AuthStore>().state;
        debugPrint('progressState => $progressState');
        if (progressState is AuthStateSuccess) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(TheSpotRouter.MAIN_ROUTE, (route) => false);
          });
        }
        if (progressState is AuthStateUnauthorized) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            showErrorDialog(context, 'Acesso não autorizado');
          });
        }
        if (progressState is AuthStateFailure) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            showErrorDialog(context, 'Ocorreu um erro inesperado.');
          });
        }
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(
            children: [
              Column(
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
                  Container(
                    padding: EdgeInsets.only(bottom: context.layoutHeight(1.5)),
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'assets/chair.svg',
                      fit: BoxFit.contain,
                      height: context.layoutHeight(55),
                    ),
                  ),
                ],
              ),
              if (progressState is AuthStateLoading)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(),
                )
            ],
          ),
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.layoutHeight(2)),
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: context.layoutHeight(5), vertical: context.layoutHeight(12)),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(context.layoutHeight(2)),
                child: Text(
                  message,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
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
          await Provider.of<AuthStore>(context, listen: false).signIn();
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
