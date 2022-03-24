import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

  Widget noTransactionLayout(BoxConstraints constraints, BuildContext context) {
    return Column(
      children: [
        Text(
          "No Transactions Found !!!",
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: constraints.maxHeight * .06),
        Container(
          height: constraints.maxHeight * .7,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
            color: Theme.of(context).primaryColorLight,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) =>
                  noTransactionLayout(constraints, context))
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 6,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TransactionItem(
                      transaction: transactions[index],
                      deleteTransaction: deleteTransaction),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
