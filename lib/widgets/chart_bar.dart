import 'package:flutter/cupertino.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      final availableHeight = constraints.biggest.height;
      final availableWidth = constraints.biggest.width;
      return Column(
        children: [
          SizedBox(
            height: availableHeight * 0.12,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: availableHeight * 0.05,
          ),
          SizedBox(
              height: availableHeight * 0.66,
              width: availableWidth * 0.25,
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CupertinoColors.inactiveGray, width: 1),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10))),
                FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                        decoration: BoxDecoration(
                            color: CupertinoColors.activeBlue,
                            borderRadius: BorderRadius.circular(10))))
              ])),
          SizedBox(
            height: availableHeight * 0.05,
          ),
          SizedBox(
            height: availableHeight * 0.12,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
