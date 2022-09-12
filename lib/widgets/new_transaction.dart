import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  const NewTransaction(this.addTX, {super.key});

  @override
  State<NewTransaction> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  CategoryOfTransaction _selectedCategory = CategoryOfTransaction.needs;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10),
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
            const Padding(padding: EdgeInsets.only(top: 8)),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Transaction Category'),
                  CupertinoButton(
                    onPressed: () {
                      _showCatDialog(mediaQuery);
                    },
                    color: CupertinoColors.systemGrey4,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    child: Text(
                      _selectedCategory.toString().split('.')[1],
                      style: const TextStyle(color: CupertinoColors.activeBlue),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              height: 80,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Text('Picked Date')),
                    CupertinoButton(
                      onPressed: () {
                        _presentDatePicker(mediaQuery);
                      },
                      color: CupertinoColors.systemGrey4,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        (_selectedDate == DateTime(0)
                            ? 'No date chosen'
                            : DateFormat('dd/MMM/yyyy').format(_selectedDate)),
                        style:
                            const TextStyle(color: CupertinoColors.activeBlue),
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

  _NewTransactionState();

  void _presentDatePicker(MediaQueryData mediaQueryData) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: mediaQueryData.viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                maximumDate: DateTime.now(),
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
    widget.addTX(enteredTitle, enteredAmount, _selectedDate, _selectedCategory);
    Navigator.of(context).pop();
  }

  void _showCatDialog(MediaQueryData mediaQueryData) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: mediaQueryData.viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32,
                // This is called when selected item is changed.
                onSelectedItemChanged: (int selectedItem) {
                  setState(() {
                    _selectedCategory =
                        CategoryOfTransaction.values[selectedItem];
                  });
                },
                children: List<Widget>.generate(
                    CategoryOfTransaction.values.length, (int index) {
                  return Center(
                    child: Text(
                      CategoryOfTransaction.values[index]
                          .toString()
                          .split('.')[1],
                    ),
                  );
                }),
              ),
            ),
          );
        });
  }
}
