import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;

  NewTransaction({Key? key, required this.addNewTransaction}) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final titleInput = titleController.text;
    final amountInput = amountController.text;

    if (titleInput.isNotEmpty && amountInput.isNotEmpty) {
      addNewTransaction(titleInput, double.parse(amountInput));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              style: const TextStyle(fontSize: 20),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              style: const TextStyle(fontSize: 20),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              onPressed: submitData,
              child: const Text(
                'Add Transaction',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
