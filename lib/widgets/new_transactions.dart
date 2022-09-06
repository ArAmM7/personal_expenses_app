import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTX;

  NewTransaction(this.addTX, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: titleController,
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                  controller: amountController,
                  //onChanged: (value) => {amountInput = value},
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  decoration: const InputDecoration(labelText: 'Amount')),
              ElevatedButton(
                  onPressed: () {
                    addTX(titleController.text,
                        double.parse(amountController.text));
                  },
                  child: const AutoSizeText('add transaction')),
            ],
          ),
        ));
  }
}
