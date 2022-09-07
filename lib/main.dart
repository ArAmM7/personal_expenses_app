import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/new_transactions.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

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
          theme: ThemeData(
              primarySwatch: Colors.teal,
              fontFamily: 'SF',
              appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                      fontFamily: 'SF',
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  secondary: Color.fromRGBO(150, 0, 14, 1),
                  onSecondary: Colors.white,
                  error: Colors.deepOrange,
                  onError: Colors.white,
                  background: Colors.white70,
                  onBackground: Colors.black87,
                  surface: Colors.purple,
                  onSurface: Colors.black87)),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];

  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 126.47,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Rent',
    //   amount: 450,
    //   date: DateTime.now(),
    // ),
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () => {_startAddNewTransaction(context)},
                icon: const Icon(Icons.add)),
          ],
          title: const Text('Personal Expenses'),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    height: 160,
                    width: double.infinity,
                    child: Chart(_recentTransactions.toList())),
                TransactionList(transactions: _userTransactions),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {_startAddNewTransaction(context)},
          child: const Icon(Icons.add),
        ),
      );

  Iterable<Transaction> get _recentTransactions {
    return _userTransactions.where((element) =>
        element.date.isAfter(DateTime.now().subtract(const Duration(days: 7))));
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }
}
