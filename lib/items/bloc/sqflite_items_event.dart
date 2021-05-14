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

class SqfliteCreateItem extends SqfliteItemsEvent {
  final SqfliteItem item;

  const SqfliteCreateItem({required this.item});

  @override
  List<Object> get props => [item];
}

class SqfliteUpdateItem extends SqfliteItemsEvent {
  final SqfliteItem item;

  const SqfliteUpdateItem({required this.item});

  @override
  List<Object> get props => [item];
}

class SqfliteDeleteItem extends SqfliteItemsEvent {
  final SqfliteItem item;

  const SqfliteDeleteItem({required this.item});

  @override
  List<Object> get props => [item];
}

class SqfliteItemsUpdated extends SqfliteItemsEvent {
  final List<SqfliteItem> items;

  const SqfliteItemsUpdated({required this.items});

  @override
  List<Object> get props => [items];
}
