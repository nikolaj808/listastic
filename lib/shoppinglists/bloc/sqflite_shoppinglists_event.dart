part of 'sqflite_shoppinglists_bloc.dart';

abstract class SqfliteShoppinglistsEvent extends Equatable {
  const SqfliteShoppinglistsEvent();

  @override
  List<Object> get props => [];
}

class SqfliteLoadShoppinglists extends SqfliteShoppinglistsEvent {}

class SqfliteShoppinglistsUpdated extends SqfliteShoppinglistsEvent {
  final List<SqfliteShoppinglist> shoppinglists;

  const SqfliteShoppinglistsUpdated({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];
}
