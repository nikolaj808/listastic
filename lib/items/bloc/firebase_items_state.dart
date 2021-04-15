part of 'firebase_items_bloc.dart';

@immutable
abstract class FirebaseItemsState extends Equatable {
  const FirebaseItemsState();

  @override
  List<Object> get props => [];
}

class FirebaseItemsInitial extends FirebaseItemsState {}

class FirebaseItemsLoading extends FirebaseItemsState {}

class FirebaseItemsLoaded extends FirebaseItemsState {
  final List<FirebaseItem> items;

  // ignore: sort_constructors_first
  const FirebaseItemsLoaded({required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'ItemsLoaded { items: $items }';
}

class FirebaseItemsEmpty extends FirebaseItemsState {}
