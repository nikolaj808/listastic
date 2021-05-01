import 'package:equatable/equatable.dart';

class SqfliteShoppinglist extends Equatable {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const SqfliteShoppinglist({
    this.id,
    required this.name,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  SqfliteShoppinglist copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return SqfliteShoppinglist(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  // ignore: sort_constructors_first
  factory SqfliteShoppinglist.fromMap(Map<String, dynamic> map) {
    return SqfliteShoppinglist(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(map['lastModifiedAt'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object> get props => [
        id ?? -1,
        name,
        createdAt,
        lastModifiedAt,
      ];
}
