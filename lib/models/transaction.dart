class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  dynamic categoryOfTransaction;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.categoryOfTransaction});
}

enum CategoryOfTransaction { needs, savings, wants }
