// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';
import 'package:flutter/services.dart';

import 'widgets/chart.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Manager',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                bodyText1: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get recentTranacrtions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmt, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: txAmt,
      date: selectedDate,
      title: txTitle,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _addNewTransactionModel(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(addNewTransaction: _addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  bool _showCharts = false;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("Personal Expense Manager"),
      actions: [
        IconButton(
            onPressed: () => _addNewTransactionModel(context),
            icon: const Icon(Icons.add))
      ],
    );
    var transactionlistWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          .8,
      child: TransactionList(
          transactions: _userTransactions,
          deleteTransaction: _deleteTransaction),
    );
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Charts',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                      value: _showCharts,
                      onChanged: (val) {
                        setState(() {
                          _showCharts = val;
                        });
                      })
                ],
              ),
            if (isLandscape)
              _showCharts
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          .8,
                      child: Charts(transactions: recentTranacrtions),
                    )
                  : transactionlistWidget,
            if (!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    .3,
                child: Charts(transactions: recentTranacrtions),
              ),
            if (!isLandscape) transactionlistWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewTransactionModel(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
