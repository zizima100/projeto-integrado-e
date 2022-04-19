import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/auth/auth_store.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset('assets/logo_with_chair.svg'),
        Column(
          children: [
            const Text(
              'Sair',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () async {
                  await Provider.of<AuthStore>(context, listen: false).signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                iconSize: context.layoutWidth(6),
              ),
            ),
          ],
        )
      ],
    );
  }
}
