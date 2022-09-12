import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTX,
  });

  final List<Transaction> transactions;
  final Function deleteTX;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No transactions added yet',
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                      isAntiAlias: true,
                    )),
              ],
            );
          })
        : SelectionArea(
            child: SingleChildScrollView(
              controller: PrimaryScrollController.of(context),
              child: Scrollbar(
                child: CupertinoFormSection(
                  clipBehavior: Clip.hardEdge,
                  children: transactions.map((e) {
                    return TransactionItem(
                        key: ValueKey(e.id),
                        transaction: e,
                        deleteTX: deleteTX,
                        mediaQuery: mediaQuery);
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
