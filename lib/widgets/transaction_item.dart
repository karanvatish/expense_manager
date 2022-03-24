import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  final Function deleteTransaction;

  const TransactionItem(
      {required Transaction this.transaction,
      required Function this.deleteTransaction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border:
                Border.all(width: 2, color: Theme.of(context).primaryColor)),
        child: Text(
          'Rs ${transaction.amount.toStringAsFixed(0)}/-',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ),
      title: Text(
        transaction.title,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        DateFormat.yMMMd().format(transaction.date),
      ),
      trailing: MediaQuery.of(context).size.width > 600
          ? TextButton.icon(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              label: Text(
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              onPressed: () => deleteTransaction(transaction.id),
            )
          : IconButton(
              onPressed: () => deleteTransaction(transaction.id),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              )),
    );
  }
}
