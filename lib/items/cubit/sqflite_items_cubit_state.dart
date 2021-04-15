part of 'sqflite_items_cubit.dart';

abstract class SqfliteItemsCubitState extends Equatable {
  const SqfliteItemsCubitState();

  @override
  List<Object> get props => [];
}

class SqfliteItemsIdle extends SqfliteItemsCubitState {}

class SqfliteItemCreating extends SqfliteItemsCubitState {}

class SqfliteItemCreateSuccess extends SqfliteItemsCubitState {
  final SqfliteItem item;

  // ignore: sort_constructors_first
  SqfliteItemCreateSuccess({required this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'SqfliteItemCreateSuccess { item: $item }';
}

class SqfliteItemUpdating extends SqfliteItemsCubitState {}

class SqfliteItemUpdateSuccess extends SqfliteItemsCubitState {}

class SqfliteItemError extends SqfliteItemsCubitState {
  final String message;

  // ignore: sort_constructors_first
  SqfliteItemError({required this.message});

  @override
  List<Object> get props => [message];
}
