part of 'sqflite_shoppinglists_bloc.dart';

abstract class SqfliteShoppinglistsEvent extends Equatable {
  const SqfliteShoppinglistsEvent();

  @override
  List<Object> get props => [];
}

class SqfliteLoadShoppinglists extends SqfliteShoppinglistsEvent {}

class SqfliteShoppinglistsUpdated extends SqfliteShoppinglistsEvent {
  final List<SqfliteShoppinglist> shoppinglists;

  // ignore: sort_constructors_first
  const SqfliteShoppinglistsUpdated({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];
}
