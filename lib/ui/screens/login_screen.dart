import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:thespot/store/login_store.dart';

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
              SvgPicture.asset('assets/logo.svg'),
              SizedBox(
                height: 4.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: const _GoogleSignInButton(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset('assets/chair.svg'),
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
        ),
        onPressed: () async {
          await Provider.of<Login>(context, listen: false).login();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.8.h),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/google_logo.svg',
                height: 5.w,
              ),
              SizedBox(
                width: 2.5.w,
              ),
              Text(
                'Login with Google',
                style: TextStyle(
                  fontSize: 12.sp,
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
