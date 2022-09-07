import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  const NewTransaction(this.addTX, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amountController,

                //onChanged: (value) => {amountInput = value},
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                decoration: const InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => submitData(),
              ),
              ElevatedButton(
                  onPressed: () => submitData(),
                  child: const AutoSizeText('add transaction')),
            ],
          ),
        ));
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTX(enteredTitle, enteredAmount);
    // titleController.clear();
    // amountController.clear();
    Navigator.of(context).pop();
  }
}
