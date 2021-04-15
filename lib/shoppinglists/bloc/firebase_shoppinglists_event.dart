part of 'firebase_shoppinglists_bloc.dart';

abstract class FirebaseShoppinglistsEvent extends Equatable {
  const FirebaseShoppinglistsEvent();

  @override
  List<Object> get props => [];
}

class FirebaseLoadShoppinglists extends FirebaseShoppinglistsEvent {}

class FirebaseShoppinglistsUpdated extends FirebaseShoppinglistsEvent {
  final List<FirebaseShoppinglist> shoppinglists;

  // ignore: sort_constructors_first
  const FirebaseShoppinglistsUpdated({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];
}
