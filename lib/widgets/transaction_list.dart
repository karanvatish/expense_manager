import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 750,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No Transactions Found !!!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 30),
                Container(
                  height: 500,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Theme.of(context).primaryColor)),
                      child: Text(
                        'Rs ${transactions[index].amount.toStringAsFixed(0)}/-',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
