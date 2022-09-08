import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/new_transactions.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    //    dummy data
    Transaction(
        id: DateTime.now().toString(),
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Weekly Groceries',
      amount: 126.47,
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
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now()),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Weekly Groceries',
      amount: 126.47,
      date: DateTime.now(),
    ),
    Transaction(
      id: DateTime.now().toString(),
      title: 'Rent',
      amount: 450,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () => {_startAddNewTransaction(context)},
              icon: const Icon(Icons.add)),
        ],
        title: const Text('Personal Expenses'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: availableHeight * 0.25,
                alignment: Alignment.center,
                width: double.infinity,
                child: Chart(_recentTransactions.toList())),
            SizedBox(
              height: availableHeight * 0.75,
              child: TransactionList(
                  transactions: _userTransactions,
                  deleteTX: _deleteTransaction),
            ),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_startAddNewTransaction(context)},
        child: const Icon(Icons.add),
      ),
    );
  }

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
