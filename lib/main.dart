import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/user_transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Personal Expenses',
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  List<Transaction> transactions = [];

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.blueAccent,
                    elevation: 5,
                    child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: double.infinity,
                        child: const Text('chart'))),
                const UserTransactions(),
              ]),
        ));
  }
}
