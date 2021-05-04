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

  SqfliteItemCreateSuccess({required this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'SqfliteItemCreateSuccess { item: $item }';
}

class SqfliteItemUpdating extends SqfliteItemsCubitState {}

class SqfliteItemUpdateSuccess extends SqfliteItemsCubitState {}

class SqfliteItemDeleting extends SqfliteItemsCubitState {}

class SqfliteItemDeleteSuccess extends SqfliteItemsCubitState {}

class SqfliteItemError extends SqfliteItemsCubitState {
  final String message;

  SqfliteItemError({required this.message});

  @override
  List<Object> get props => [message];
}
