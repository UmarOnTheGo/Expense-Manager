class Tag {
  final String id;
  final String tagName;

  static int _counter = 0;

  static int _generateID() {
    _counter++;
    return _counter;
  }

  Tag({required this.tagName}) : id = 'TAG-$_generateID()';

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag._fromJsonInternal(id: json['id'], tagName: json['tagName']);
  }

  Tag._fromJsonInternal({required this.id, required this.tagName});

  Map<String, dynamic> toJson() {
    return {'id': id, 'tagName': tagName};
  }
}
