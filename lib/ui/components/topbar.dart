import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/auth/auth_store.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.layoutWidth(5),
        vertical: context.layoutWidth(3),
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/logo_with_chair.svg',
            fit: BoxFit.fill,
            height: context.layoutWidth(18),
          ),
          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double iconPaddingSize = 8;

    return Column(
      children: [
        const Text(
          'Sair',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'Roboto',
          ),
        ),
        Material(
          color: Colors.transparent,
          child: SizedBox(
            height: context.layoutWidth(iconPaddingSize),
            width: context.layoutWidth(iconPaddingSize),
            child: IconButton(
              onPressed: () {
                Provider.of<AuthStore>(context, listen: false).signOut();
                Provider.of<ReserveStore>(context, listen: false).resetState();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
                size: context.layoutWidth(6),
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
