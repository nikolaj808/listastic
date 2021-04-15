import 'package:equatable/equatable.dart';

class SqfliteShoppinglistEntity extends Equatable {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const SqfliteShoppinglistEntity({
    this.id,
    required this.name,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  SqfliteShoppinglistEntity copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return SqfliteShoppinglistEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
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

  // ignore: sort_constructors_first
  factory SqfliteShoppinglistEntity.fromMap(Map<String, dynamic> json) {
    return SqfliteShoppinglistEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(json['lastModifiedAt'] as int),
    );
  }

  @override
  List<Object> get props => [
        name,
      ];
}
