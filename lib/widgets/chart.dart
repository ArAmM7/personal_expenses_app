import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (weekday.day == recentTransactions[i].date.day &&
            weekday.month == recentTransactions[i].date.month &&
            weekday.year == recentTransactions[i].date.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(6),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ...groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: data['day'].toString(),
                    spendingAmount: (data['amount'] as double),
                    spendingPctOfTotal: totalSpending == 0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList()
          ]),
        ));
  }
}
