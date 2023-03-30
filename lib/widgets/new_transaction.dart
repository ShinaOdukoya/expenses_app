import 'dart:io';

import '../widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction({Key? key, required this.addTransaction})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    //This line of code prevents error
    //when submit button is clicked
    //without entering amount.
    //It is also important to write the
    //piece of code here so that it
    //prevents the error.
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    /**This is the method assigned to
     * onPressed but because the piece
     * of code is required in several
     * places I had to wrap it inisde
     * a name function
     */
    widget.addTransaction(
      enteredTitle, //titleController.text,
      enteredAmount, //double.parse(amountController.text),
      _selectedDate,
    );

    //I added this
    // titleController.text = '';
    // amountController.text = '';

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return null;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            /**To address softkeyboard in
             * landscape mode or on
             * smaller devices.
             * Also, wrapping the container
             * with SingleChildScrollView
             * cos BottomSheet has fixed
             * size
             */
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (value) => amountInput = value,
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    //Expanded is needed to
                    //make the items stretch
                    //i.e take all the space
                    //in the row
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date is ${DateFormat.yMd().format(_selectedDate!)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  AdaptiveButton('Choose Date', _presentDatePicker)
                ],
              ),
            ),
            ElevatedButton(
              // onPressed: submitData,
              onPressed: () {
                _submitData();
                // print(titleController.text);
              },
              child: const Text(
                'Add Transaction',
                style: TextStyle(
                    // color: Colors.purple,
                    // color: Theme.of(context).primaryColor,

                    // The default is white
                    // Just wanted to set the below explicitly
                    // color: Theme.of(context).textTheme.button?.color,
                    ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
