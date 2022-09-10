import 'package:flutter/cupertino.dart';
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

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            CupertinoTextField(
              controller: _titleController,
              padding: const EdgeInsets.all(12),
              maxLength: 32,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              placeholder: 'Title',
              onSubmitted: (_) => _submitData(),
            ),
            CupertinoTextField(
              controller: _amountController,
              padding: const EdgeInsets.all(12),
              prefix: const Text('   \$'),
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: true),
              placeholder: 'Amount',
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              height: 80,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: Text(_selectedDate == DateTime(0)
                        ? 'No date chosen'
                        : 'Picked Date ${DateFormat('dd/MMM/yyyy').format(_selectedDate)}')),
                CupertinoButton(
                  onPressed: _presentDatePicker,
                  color: CupertinoColors.systemGrey4,
                  padding: const EdgeInsets.all(12),
                  child: const Text(
                    'Choose Date',
                    style: TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
              ]),
            ),
            CupertinoButton(
              onPressed: () => _submitData(),
              color: CupertinoColors.activeBlue,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _selectedDate = value;
                  });
                },
              ),
            ),
          );
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
    Navigator.of(context).pop();
  }
}
