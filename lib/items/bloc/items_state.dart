part of 'items_bloc.dart';

@immutable
abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsInitial extends ItemsState {}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Item> items;

  // ignore: sort_constructors_first
  const ItemsLoaded({required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ItemsLoaded { items: $items }';
}

class ItemsEmpty extends ItemsState {}
