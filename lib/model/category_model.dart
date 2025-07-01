class Category {
  final String id;
  final String catName;

  static int _counter = 0;

  static int _generateID() {
    _counter++;
    return _counter;
  }

  Category({required this.catName}) : id = 'CAT-$_generateID()';

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category._fromJsonInternal(id: json['id'], catName: json['catName']);
  }
  Category._fromJsonInternal({required this.id, required this.catName});

  Map<String, dynamic> toJson() {
    return {'id': id, 'catName': catName};
  }
}
