import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/reserve/reserve_state.dart';
import 'package:thespot/store/reserve/reserve_store.dart';

class ReserveScreen extends StatelessWidget {
  const ReserveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var state = context.watch<ReserveStore>().state;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.toString()),
              ElevatedButton(
                onPressed: () {
                  if (state is ReserveStateInitial) {
                    context.read<ReserveStore>().start();
                  } else if (state is ReserveStateChooseDateAndSeat) {
                    context.read<ReserveStore>().chooseSeat();
                  } else if (state is ReserveStateConfirmation) {
                    context.read<ReserveStore>().confirm();
                  }
                },
                child: const Text('Próximo'),
              ),
            ],
          ),
        );
      },
    );
  }
}
