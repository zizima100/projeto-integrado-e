import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_state.dart';
import 'package:thespot/store/reserve_or_query/reserve_or_query_store.dart';
import 'package:thespot/ui/screens/reserve/reserve_screen.dart';

class ReserveOrQueryScreen extends StatelessWidget {
  const ReserveOrQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO replace message with actual widgets
    return Observer(builder: (_) {
      var state = context.watch<ReserveOrQueryStore>().state;
      debugPrint('ReserveOrQueryScreen state => $state');
      return ReserveScreen();
      if (state is ReserveOrQueryQuerying) {
      }
      return Container();
    });
  }
}
