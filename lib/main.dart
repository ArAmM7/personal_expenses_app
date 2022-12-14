import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
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
      child: CupertinoApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(fontFamily: 'SF', fontSize: 12),
            navTitleTextStyle: TextStyle(
                fontFamily: 'SF', color: CupertinoColors.label, fontWeight: FontWeight.w600),
            textStyle: TextStyle(fontFamily: 'SF', color: CupertinoColors.label),
          ),
        ),
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
        ],
        title: 'Personal Expenses',
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Transaction> transactions = [];

  final List<Transaction> _userTransactions = [
    //dummy data
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Shoes',
        amount: 74.99,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.wants),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Groceries',
        amount: 26.47,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Rent',
        amount: 450,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Pants',
        amount: 69.99,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.wants),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Groceries',
        amount: 16.58,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Utilities',
        amount: 120,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Shoes',
        amount: 74.99,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.wants),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Groceries',
        amount: 26.47,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Rent',
        amount: 450,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Pants',
        amount: 69.99,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.wants),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Groceries',
        amount: 16.58,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Utilities',
        amount: 120,
        date: DateTime.now(),
        categoryOfTransaction: CategoryOfTransaction.needs),
  ];
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = CupertinoNavigationBar(
      middle: const Text('Personal Expenses'),
      trailing: GestureDetector(
          onTap: () => {_startAddNewTransaction(context)}, child: const Icon(CupertinoIcons.add)),
    );

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final availableHeight =
        (mediaQuery.size.height - mediaQuery.padding.top - appBar.preferredSize.height);
    final transactionList = SizedBox(
      height: availableHeight * 0.75,
      child: TransactionList(transactions: _userTransactions, deleteTX: _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: Column(
        children: <Widget>[
          if (!isLandscape) ..._buildPortraitContent(availableHeight, transactionList),
          if (isLandscape) ..._buildLandscapeContent(availableHeight, transactionList),
        ],
      ),
    );

    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: pageBody,
    );
  }

  Iterable<Transaction> get _recentTransactions {
    return _userTransactions
        .where((element) => element.date.isAfter(DateTime.now().subtract(const Duration(days: 7))));
  }

  void _startAddNewTransaction(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _addNewTransaction(
      String title, double amount, DateTime date, CategoryOfTransaction category) {
    final newTX = Transaction(
        categoryOfTransaction: category,
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(() => _userTransactions.removeWhere((element) => element.id == id));
  }

  List<Widget> _buildLandscapeContent(double availableHeight, SizedBox transactionList) {
    return [
      SizedBox(
        height: availableHeight * 0.15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSlidingSegmentedControl(
              groupValue: _showChart,
              onValueChanged: (value) {
                setState(() {
                  _showChart = value!;
                });
              },
              children: const <bool, Widget>{false: Text("Chart"), true: Text("Transactions")},
            ),
          ],
        ),
      ),
      _showChart
          ? Container(
              height: availableHeight * 0.75,
              alignment: Alignment.center,
              width: double.infinity,
              child: transactionList)
          : Container(
              height: availableHeight * 0.75,
              alignment: Alignment.center,
              width: double.infinity,
              child: Chart(_recentTransactions.toList()))
    ];
  }

  List<Widget> _buildPortraitContent(double availableHeight, SizedBox transactionList) {
    return [
      Container(
          height: availableHeight * 0.25,
          alignment: Alignment.center,
          width: double.infinity,
          child: Chart(_recentTransactions.toList())),
      transactionList
    ];
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
