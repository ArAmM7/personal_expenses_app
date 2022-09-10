import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
                  clipBehavior: Clip.antiAlias,
                  children: transactions.map((e) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.centerRight,
                        color: CupertinoColors.destructiveRed,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(CupertinoIcons.delete_solid,
                                  color: CupertinoColors.white),
                              Text(
                                'Delete',
                                style: TextStyle(color: CupertinoColors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      onDismissed: (dir) {
                        if (dir == DismissDirection.endToStart) {
                          deleteTX(e.id);
                        }
                      },
                      key: Key(e.id),
                      child: CupertinoFormRow(
                        prefix: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 24, left: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      e.title,
                                      style: const TextStyle(
                                          fontWeight:FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MMM/yyyy').format(e.date),
                                    style: const TextStyle(
                                        color: CupertinoColors.inactiveGray),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: 144,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: FittedBox(
                            child: Text(
                              '\$${e.amount}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
