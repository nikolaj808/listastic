part of 'shoppinglists_bloc.dart';

abstract class ShoppinglistsState extends Equatable {
  const ShoppinglistsState();

  @override
  List<Object> get props => [];
}

class ShoppinglistsInitial extends ShoppinglistsState {}

class ShoppinglistsLoading extends ShoppinglistsState {}

class ShoppinglistsLoaded extends ShoppinglistsState {
  final List<Shoppinglist> shoppinglists;

  // ignore: sort_constructors_first
  const ShoppinglistsLoaded({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];

  @override
  String toString() => 'ShoppinglistsLoaded { shoppinglists: $shoppinglists }';
}
