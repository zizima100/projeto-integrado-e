import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thespot/data/model/seat.dart';
import 'package:thespot/data/provider/constants.dart';
import 'package:thespot/store/reserve/reserve_store.dart';
import 'package:thespot/ui/colors.dart';
import 'package:thespot/ui/extensions/ui_extensions.dart';
import 'package:thespot/ui/text_style.dart';

class SeatsWidget extends StatelessWidget {
  final bool interactive;
  final List<Seat>? seats;
  final int? indexSelected;

  const SeatsWidget({
    Key? key,
    required this.interactive,
    this.seats,
    this.indexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SeatsGridView(
      seats: _seats,
      onSeatTap: interactive
          ? (int id) {
              Provider.of<ReserveStore>(
                context,
                listen: false,
              ).onSeatTap(id);
            }
          : null,
    );
  }

  List<Seat> get _seats {
    if (interactive) {
      return seats!;
    }
    return List.generate(Constants.NUMBER_OF_SEATS, (index) {
      if (index == indexSelected) {
        return Seat(
          id: Seat.idFromGridViewIndex(index),
          status: SeatStatus.selected,
        );
      }
      return Seat(
        id: Seat.idFromGridViewIndex(index),
        status: SeatStatus.unavailable,
      );
    });
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
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.count(
        // physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.1,
        crossAxisCount: 4,
        mainAxisSpacing: constraints.maxWidth / 35,
        crossAxisSpacing: constraints.maxWidth / 35,
        children: seats.map((seat) {
          return GestureDetector(
            onTap: () {
              if (onSeatTap != null) {
                onSeatTap!(seat.id);
              }
            },
            child: _SeatWidget(
              style: _getStyle(seat),
            ),
          );
        }).toList(),
      );
    });
  }

  _SeatStyle _getStyle(Seat seat) {
    if (seat.status.isAvailable && onSeatTap != null) {
      return _SeatStyle(
        borderColor: TheSpotColors.blue,
        color: Colors.transparent,
        text: seat.id.toString(),
        textColor: Colors.black,
      );
    } else if (seat.status.isSelected) {
      return _SeatStyle(
        borderColor: Colors.transparent,
        color: TheSpotColors.blue,
        text: seat.id.toString(),
        textColor: Colors.white,
      );
    } else {
      return _SeatStyle(
        borderColor: Colors.transparent,
        color: Colors.grey.shade300,
        text: seat.id.toString(),
        textColor: Colors.grey.shade500,
      );
    }
  }

  Color getColor(SeatStatus status) {
    if (status.isAvailable && onSeatTap != null) {
      return Colors.green;
    } else if (status.isSelected) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }
}

class _SeatStyle {
  final Color borderColor;
  final Color color;
  final String text;
  final Color textColor;

  _SeatStyle({
    required this.borderColor,
    required this.color,
    required this.text,
    required this.textColor,
  });
}

class _SeatWidget extends StatelessWidget {
  final _SeatStyle style;

  const _SeatWidget({
    Key? key,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: style.borderColor,
          width: 1.2,
        ),
        color: style.color,
      ),
      child: Center(
        child: Text(
          style.text,
          style: TheSpotTextStyle.defaultStyle.copyWith(
            color: style.textColor,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}