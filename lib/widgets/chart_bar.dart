import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
            height: 96,
            width: 10,
            child: Stack(children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10))),
              FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10))))
            ])),
        const SizedBox(
          height: 4,
        ),
        AutoSizeText(label),
      ],
    );
  }
}
