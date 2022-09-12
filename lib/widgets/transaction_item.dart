import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:personal_expenses_app/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTX,
    required this.mediaQuery,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTX;
  final MediaQueryData mediaQuery;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const availableColors =
  { CategoryOfTransaction.needs: CupertinoColors.systemTeal,
    CategoryOfTransaction.wants: CupertinoColors.systemYellow,
    CategoryOfTransaction.savings: CupertinoColors.systemPurple,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.all(4),
        alignment: Alignment.centerRight,
        color: CupertinoColors.destructiveRed,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(CupertinoIcons.delete_solid, color: CupertinoColors.white),
              Text(
                'Delete',
                style: TextStyle(color: CupertinoColors.white),
              )
            ],
          ),
        ),
      ),
      onDismissed: (dir) {
        if (dir == DismissDirection.endToStart) {
          widget.deleteTX(widget.transaction.id);
        }
      },
      key: Key(widget.transaction.id),
      child: CupertinoFormRow(
        prefix: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widget.mediaQuery.size.width * 0.5,
                    child: Text(
                      widget.transaction.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    DateFormat('dd/MMM/yyyy').format(widget.transaction.date),
                    style: const TextStyle(color: CupertinoColors.inactiveGray),
                  )
                ],
              ),
            ),
          ],
        ),
        child: Container(
          color: availableColors[widget.transaction.categoryOfTransaction],
          alignment: Alignment.centerRight,
          width: 144,
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: FittedBox(
            child: Text(
              '\$${widget.transaction.amount}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
