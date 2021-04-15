part of 'sqflite_items_bloc.dart';

abstract class SqfliteItemsEvent extends Equatable {
  const SqfliteItemsEvent();

  @override
  List<Object> get props => [];
}

class SqfliteLoadItems extends SqfliteItemsEvent {}

class SqfliteItemsUpdated extends SqfliteItemsEvent {
  final List<SqfliteItem> items;

  // ignore: sort_constructors_first
  const SqfliteItemsUpdated({required this.items});

  @override
  List<Object> get props => [items];
}
