import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/routes/routes.dart';
import 'package:thespot/store/auth/auth_state.dart';
import 'package:thespot/store/auth/auth_store.dart';
import 'package:thespot/store/query/query_store.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_state.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_store.dart';
import 'package:thespot/ui/components/topbar.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';
import 'package:thespot/ui/screens/query_screen.dart';
import 'package:thespot/ui/screens/reserve_screen.dart';

class ReserveOrQueryScreen extends StatelessWidget {
  const ReserveOrQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ReserveOrQueryScreen build');
    var reserveOrQueryStore = context.watch<ReserveOrQueryStore>();
    reserveOrQueryStore.reserveOrQuery();
    const double topBarLayoutRatio = 20;

    return SafeArea(
      child: Observer(builder: (_) {
        var reserveOrQueryState = reserveOrQueryStore.state;
        var authState = context.watch<AuthStore>().state;
        if (authState is AuthStateLoggout) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              TheSpotRouter.AUTH_ROUTE,
              (route) => false,
            );
          });
        }
        debugPrint('ReserveOrQueryScreen state => $reserveOrQueryState');
        return Column(
          children: [
            SizedBox(
              height: context.layoutHeight(topBarLayoutRatio),
              child: const TopBar(),
            ),
            Expanded(
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: reserveOrQueryState is ReserveOrQueryReserving
                    ? const ReserveScreen()
                    : const QueryScreen(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
