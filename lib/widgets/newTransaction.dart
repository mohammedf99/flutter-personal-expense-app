import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  void _addNewTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text.toString());

    if (enteredTitle.isEmpty ||
        enteredAmount.isNaN ||
        enteredAmount.isNegative ||
        selectedDate == null) {
      return;
    }

    widget.addTransaction(titleController.text,
        double.parse(amountController.text.toString()), selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        selectedDate = pickedDate;
      });
    }); // it doesn't block the app, it will be stored in memory
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Expense Title',
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                // onChanged: (val) => textInput = val,
                controller: titleController,
                onSubmitted: (_) => _addNewTransaction(),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                // onChanged: (val) => amountInput = val,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addNewTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(selectedDate == null
                          ? 'No date choosen!'
                          : DateFormat.yMMMEd().format(selectedDate!)),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Select a date',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ]),
              ),
              ElevatedButton(
                onPressed: _addNewTransaction,
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 35)),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}