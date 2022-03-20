// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({Key? key, required this.addNewTransaction}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _showDatePickerWidget() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  void _submitData() {
    final enteredInput = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredInput.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(enteredInput, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10,
              top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                style: TextStyle(fontSize: 20),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                style: TextStyle(fontSize: 20),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date chossen'
                          : 'Date Selected : ${DateFormat.yMMMd().format(_selectedDate!)}',
                      style: _selectedDate == null
                          ? Theme.of(context).textTheme.headline6
                          : Theme.of(context).textTheme.bodyText1,
                    ),
                    IconButton(
                        onPressed: _showDatePickerWidget,
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
