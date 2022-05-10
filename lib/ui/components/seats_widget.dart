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
          return _SeatsGridView(
            seats: reserveState.seats,
            onSeatTap: (int id) {
              Provider.of<ReserveStore>(context, listen: false).onSeatTap(id);
            },
          );
        }
        return Container();
      },
    );
  }
}

class ReadOnlySeatsWidget extends StatelessWidget {
  final int selectedIndex;

  const ReadOnlySeatsWidget({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _SeatsGridView extends StatelessWidget {
  final List<Seat> seats;
  final Function(int)? onSeatTap;

  const _SeatsGridView({
    Key? key,
    required this.seats,
    this.onSeatTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: seats.map((seat) {
        return GestureDetector(
          onTap: () {
            if (onSeatTap != null) {
              onSeatTap!(seat.id);
            }
          },
          child: SeatWidget(
            id: seat.id,
            color: getColor(seat.status),
          ),
        );
      }).toList(),
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
    return Container(
      margin: const EdgeInsets.all(10),
      color: color,
      child: Center(
        child: Text(
          id.toString(),
          style: TheSpotTextStyle.defaultStyle,
        ),
      ),
    );
  }
}
