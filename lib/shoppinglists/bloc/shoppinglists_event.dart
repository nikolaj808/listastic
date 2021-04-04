part of 'shoppinglists_bloc.dart';

abstract class ShoppinglistsEvent extends Equatable {
  const ShoppinglistsEvent();

  @override
  List<Object> get props => [];
}

class LoadShoppinglists extends ShoppinglistsEvent {}

class ShoppinglistsUpdated extends ShoppinglistsEvent {
  final List<Shoppinglist> shoppinglists;

  // ignore: sort_constructors_first
  const ShoppinglistsUpdated({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];
}

class CreateShoppinglist extends ShoppinglistsEvent {
  final Shoppinglist shoppinglist;

  // ignore: sort_constructors_first
  const CreateShoppinglist({required this.shoppinglist});

  @override
  List<Object> get props => [shoppinglist];

  @override
  String toString() => 'CreateShoppinglist { shoppinglist: $shoppinglist }';
}

class UpdateShoppinglist extends ShoppinglistsEvent {
  final Shoppinglist shoppinglist;

  // ignore: sort_constructors_first
  const UpdateShoppinglist({required this.shoppinglist});

  @override
  List<Object> get props => [shoppinglist];

  @override
  String toString() => 'UpdateShoppinglist { shoppinglist: $shoppinglist }';
}

class DeleteShoppinglist extends ShoppinglistsEvent {
  final Shoppinglist shoppinglist;

  // ignore: sort_constructors_first
  const DeleteShoppinglist({required this.shoppinglist});

  @override
  List<Object> get props => [shoppinglist];

  @override
  String toString() => 'DeleteShoppinglist { shoppinglist: $shoppinglist }';
}
