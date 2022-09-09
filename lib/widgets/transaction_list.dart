import 'package:flutter/cupertino.dart';
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
        : SingleChildScrollView(
            child: CupertinoFormSection(
              clipBehavior: Clip.antiAlias,
              children: transactions.map((e) {
                return CupertinoFormRow(
                  prefix: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemYellow,
                            borderRadius: BorderRadius.circular(12.0)),
                        width: 80,
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: FittedBox(
                          child: Text(
                            '\$${e.amount}',
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width*0.5,child: Text(e.title),),
                              Text(
                                DateFormat('dd/MMM/yyyy').format(e.date),
                              )
                            ]),
                      ),
                      CupertinoButton(
                        onPressed: () => deleteTX(e.id),
                        child: const Icon(CupertinoIcons.delete),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
  }
}
