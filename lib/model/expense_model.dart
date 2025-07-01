class Expense {
  final String id;
  final String payee;
  final double amount;
  final String note;
  final DateTime date;
  final String tag;
  final String category;

  static int _counter = 0;

  static String _generateID() {
    _counter++;
    return 'Exp-$_counter';
  }

  Expense({
    required this.payee,
    required this.amount,
    required this.note,
    required this.date,
    required this.tag,
    required this.category,
  }) : id = _generateID();

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense._fromJsonInternal(
      id: json['id'],
      payee: json['payee'],
      amount: (json['amount'] as num).toDouble(),
      note: json['note'],
      date: DateTime.parse(json['date']),
      tag: json['tag'],
      category: json['category'],
    );
  }

  // Private named constructor used only by fromJson
  Expense._fromJsonInternal({
    required this.id,
    required this.payee,
    required this.amount,
    required this.note,
    required this.date,
    required this.tag,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'payee': payee,
      'amount': amount,
      'note': note,
      'date': date.toIso8601String(),
      'tag': tag,
      'category': category,
    };
  }
}
