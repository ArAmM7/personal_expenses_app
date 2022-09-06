import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import '../models/transaction.dart';
import 'new_transactions.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserTransaction();
  }
}

class _UserTransaction extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 126.47,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String title, double amount) {
    final newTX = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(transactions: _userTransactions)
      ],
    );
  }
}
