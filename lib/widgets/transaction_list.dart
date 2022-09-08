import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                Text('No transactions added yet',
                    style: Theme.of(context).textTheme.titleLarge),
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
        : ListView.builder(
            itemBuilder: (ctx, index) {
              //    regular text
              // return Card(
              //   elevation: 2,
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 100,
              //         margin: const EdgeInsets.symmetric(
              //             vertical: 10, horizontal: 15),
              //         padding: const EdgeInsets.all(5),
              //         // decoration: BoxDecoration(
              //         //     border: Border.all(width: 1, color: Colors.greenAccent),
              //         //     color: Colors.white60),
              //         child: FittedBox(
              //           child: Text(
              //             '\$ ${transactions[index].amount.toStringAsFixed(2)}',
              //             style: TextStyle(
              //                 fontSize: 24,
              //                 color: Theme.of(context).primaryColor),
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             transactions[index].title,
              //             style: Theme.of(context).textTheme.headline6,
              //           ),
              //           Text(
              //             DateFormat('HH:MM - dd/MMM/yyyy')
              //                 .format(transactions[index].date),
              //             style: Theme.of(context).textTheme.bodyMedium,
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );

              //  text with pill shaped card
              // return Card(
              //   elevation: 4,
              //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              //   child: ListTile(
              //     leading: Card(
              //       color: Theme.of(context).primaryColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12.0),
              //       ),
              //       child: Container(
              //         width: 80,
              //         height: 40,
              //         padding:
              //             EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              //         child: FittedBox(
              //           child: Text('\$${transactions[index].amount}',
              //               style: TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                   color:
              //                       Theme.of(context).colorScheme.onPrimary)),
              //         ),
              //       ),
              //     ),
              //     title: Text(
              //       transactions[index].title,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     subtitle: Text(
              //       DateFormat('HH:MM - dd/MMM/yyyy')
              //           .format(transactions[index].date),
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //   ),
              // );

              //text on circle avatar
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    radius: 36,
                    child: FittedBox(
                      child: Text(
                        '\$${transactions[index].amount}',
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat('dd/MMM/yyyy').format(transactions[index].date),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: MediaQuery.of(context).size.width > 420
                      ? ElevatedButton.icon(
                          onPressed: () => deleteTX(transactions[index].id),
                          icon: const Icon(Icons.delete_rounded),
                          label: const Text('Delete transaction'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.error),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => deleteTX(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
