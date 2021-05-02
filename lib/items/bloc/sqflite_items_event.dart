part of 'sqflite_items_bloc.dart';

abstract class SqfliteItemsEvent extends Equatable {
  const SqfliteItemsEvent();

  @override
  List<Object> get props => [];
}

class SqfliteLoadItems extends SqfliteItemsEvent {
  final int shoppinglistId;

  const SqfliteLoadItems({required this.shoppinglistId});

  @override
  List<Object> get props => [shoppinglistId];
}

class SqfliteItemsUpdated extends SqfliteItemsEvent {
  final List<SqfliteItem> items;

  const SqfliteItemsUpdated({required this.items});

  @override
  List<Object> get props => [items];
}
