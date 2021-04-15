part of 'firebase_shoppinglists_bloc.dart';

abstract class FirebaseShoppinglistsState extends Equatable {
  const FirebaseShoppinglistsState();

  @override
  List<Object> get props => [];
}

class FirebaseShoppinglistsInitial extends FirebaseShoppinglistsState {}

class FirebaseShoppinglistsLoading extends FirebaseShoppinglistsState {}

class FirebaseShoppinglistsLoaded extends FirebaseShoppinglistsState {
  final List<FirebaseShoppinglist> shoppinglists;

  // ignore: sort_constructors_first
  const FirebaseShoppinglistsLoaded({required this.shoppinglists});

  @override
  List<Object> get props => [shoppinglists];

  @override
  String toString() => 'ShoppinglistsLoaded { shoppinglists: $shoppinglists }';
}

class FirebaseShoppinglistsEmpty extends FirebaseShoppinglistsState {}
