part of 'sqflite_shoppinglists_bloc.dart';

abstract class SqfliteShoppinglistsState extends Equatable {
  const SqfliteShoppinglistsState();

  @override
  List<Object> get props => [];
}

class SqfliteShoppinglistsInitial extends SqfliteShoppinglistsState {}

class SqfliteShoppinglistsLoading extends SqfliteShoppinglistsState {}

class SqfliteShoppinglistsLoaded extends SqfliteShoppinglistsState {
  final List<SqfliteShoppinglist> shoppinglists;

  const SqfliteShoppinglistsLoaded({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];

  @override
  String toString() => 'ShoppinglistsLoaded { shoppinglists: $shoppinglists }';
}

class SqfliteShoppinglistsEmpty extends SqfliteShoppinglistsState {}
