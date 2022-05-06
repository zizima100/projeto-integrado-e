import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/store/reserve/reserve_state.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/ui/text_style.dart';

class InterativeSeatsWidget extends StatelessWidget {
  const InterativeSeatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var reserveState = context.watch<ReserveStore>().state;
        if (reserveState is ReserveStateChooseDateAndSeat) {
          return GridView.count(
            crossAxisCount: 4,
            children: reserveState.seats.map((seat) {
              return SeatWidget(
                id: seat.id,
                color: getColor(seat.status),
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }

  Color getColor(SeatStatus status) {
    if (status.isAvailable) {
      return Colors.green;
    } else if (status.isSelected) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }
}

class SeatWidget extends StatelessWidget {
  final int id;
  final Color color;

  const SeatWidget({
    Key? key,
    required this.id,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ReserveStore>(context, listen: false).onSeatTap(id);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        color: color,
        child: Center(
          child: Text(
            id.toString(),
            style: TheSpotTextStyle.defaultStyle,
          ),
        ),
      ),
    );
  }
}
