import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
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
        child: Platform.isIOS
            ? const CupertinoApp(
                title: 'Personal Expenses',
                home: MyHomePage(),
                theme: CupertinoThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.teal,
                    primaryContrastingColor: Colors.white,
                    scaffoldBackgroundColor: Colors.white70,
                    barBackgroundColor: Colors.white60,
                    textTheme: CupertinoTextThemeData(
                        primaryColor: Colors.black87,
                        textStyle: TextStyle(
                            fontFamily: 'SF',
                            fontSize: 24,
                            fontWeight: FontWeight.bold))),
              )
            : MaterialApp(
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
                        secondary: Color.fromRGBO(136, 0, 150, 1),
                        onSecondary: Colors.white,
                        error: Colors.redAccent,
                        onError: Colors.white,
                        background: Colors.white60,
                        onBackground: Colors.black87,
                        surface: Colors.white70,
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
    //    dummy data
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Shoes',
        amount: 74.99,
        date: DateTime.now()),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Groceries',
      amount: 26.47,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Rent',
      amount: 450,
      date: DateTime.now(),
    ),
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Pants',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Groceries',
      amount: 16.58,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Utilities',
      amount: 120,
      date: DateTime.now(),
    ),
  ];
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final availableHeight = (mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top);
    final transactionList = SizedBox(
      height: availableHeight * 0.75,
      child: TransactionList(
          transactions: _userTransactions, deleteTX: _deleteTransaction),
    );

    final pageBody = SafeArea(
      //TODO create stateful widget from this column
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              SizedBox(
                height: availableHeight * 0.15,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show chart',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch.adaptive(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        }),
                  ],
                ),
              ),
            if (!isLandscape)
              Container(
                  height: availableHeight * 0.25,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Chart(_recentTransactions.toList())),
            if (!isLandscape) transactionList,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: availableHeight * 0.75,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Chart(_recentTransactions.toList()))
                  : transactionList,
          ]),
    );

    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: GestureDetector(
                onTap: () => {_startAddNewTransaction(context)},
                child: const Icon(CupertinoIcons.add)),
          )
        : AppBar(
            actions: <Widget>[
              IconButton(
                  onPressed: () => {_startAddNewTransaction(context)},
                  icon: const Icon(Icons.add)),
            ],
            title: const Text('Personal Expenses'),
          );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: (appBar as ObstructingPreferredSizeWidget),
            child: pageBody,
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: (appBar as PreferredSizeWidget),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => {_startAddNewTransaction(context)},
                    child: const Icon(Icons.add),
                  ),
            body: pageBody);
  }

  Iterable<Transaction> get _recentTransactions {
    return _userTransactions.where((element) =>
        element.date.isAfter(DateTime.now().subtract(const Duration(days: 7))));
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTX = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(
        () => _userTransactions.removeWhere((element) => element.id == id));
  }
}
