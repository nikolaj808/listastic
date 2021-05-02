part of 'sqflite_items_bloc.dart';

abstract class SqfliteItemsState extends Equatable {
  const SqfliteItemsState();

  @override
  List<Object> get props => [];
}

class SqfliteItemsInitial extends SqfliteItemsState {}

class SqfliteItemsLoading extends SqfliteItemsState {}

class SqfliteItemsLoaded extends SqfliteItemsState {
  final List<SqfliteItem> items;

  const SqfliteItemsLoaded({required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ItemsLoaded { items: $items }';
}

class SqfliteItemsError extends SqfliteItemsState {
  final String message;

  const SqfliteItemsError({required this.message});

  @override
  List<Object> get props => [message];
}

class SqfliteItemsEmpty extends SqfliteItemsState {}
