part of 'items_bloc.dart';

@immutable
abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends ItemsEvent {}

class ItemsUpdated extends ItemsEvent {
  final List<Item> items;

  // ignore: sort_constructors_first
  const ItemsUpdated({required this.items});

  @override
  List<Object> get props => [items];
}

class CreateItem extends ItemsEvent {
  final Item item;

  // ignore: sort_constructors_first
  const CreateItem({required this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'CreateItem { item: $item }';
}

class UpdateItem extends ItemsEvent {
  final Item item;

  // ignore: sort_constructors_first
  const UpdateItem({required this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'UpdateItem { item: $item }';
}

class DeleteItem extends ItemsEvent {
  final Item item;

  // ignore: sort_constructors_first
  const DeleteItem({required this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'DeleteItem { item: $item }';
}
