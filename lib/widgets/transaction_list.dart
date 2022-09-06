import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
  });

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView(
        children: [
          ...transactions.map((tx) {
            return Card(
              elevation: 1,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: const EdgeInsets.all(5),
                    // decoration: BoxDecoration(
                    //     border: Border.all(width: 1, color: Colors.greenAccent),
                    //     color: Colors.white60),
                    child: AutoSizeText(
                      maxLines: 1,
                      '\$ ${tx.amount}',
                      style: const TextStyle(fontSize: 24, color: Colors.green),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        tx.title,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      AutoSizeText(
                        DateFormat('HH:MM - dd/MMM/yyyy').format(tx.date),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black26),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
