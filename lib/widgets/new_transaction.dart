import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  const NewTransaction(this.addTX, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime(0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  enableSuggestions: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: 'Title'),
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  controller: _amountController,

                  //onChanged: (value) => {amountInput = value},
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  decoration: const InputDecoration(labelText: 'Amount'),
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  height: 80,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(_selectedDate == DateTime(0)
                                ? 'No date chosen'
                                : 'Picked Date ${DateFormat('dd/MMM/yyyy').format(_selectedDate)}')),
                        TextButton(
                            onPressed: _presentDatePicker,
                            child: const Text('Choose Date')),
                      ]),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.secondary)),
                    onPressed: () => _submitData(),
                    child: const Text('add transaction')),
              ],
            ),
          )),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _selectedDate = value!;
      });
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == DateTime(0)) {
      return;
    }
    widget.addTX(enteredTitle, enteredAmount, _selectedDate);
    // titleController.clear();
    // amountController.clear();
    //_selectedDate = DateTime(0);
    Navigator.of(context).pop();
  }
}
