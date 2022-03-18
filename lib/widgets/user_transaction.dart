import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './new_transaction.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', amount: 69.99, date: DateTime.now(), title: 'New Shoes'),
    Transaction(
        id: 't2',
        amount: 16.53,
        date: DateTime.now(),
        title: 'Weekly Grocceries')
  ];

  void _addNewTransaction(String txTitle, double txAmt) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: txAmt,
      date: DateTime.now(),
      title: txTitle,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(addNewTransaction: _addNewTransaction),
        TransactionList(transactions: _userTransactions),
      ],
    );
  }
}
