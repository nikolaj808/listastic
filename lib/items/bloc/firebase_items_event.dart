part of 'firebase_items_bloc.dart';

@immutable
abstract class FirebaseItemsEvent extends Equatable {
  const FirebaseItemsEvent();

  @override
  List<Object> get props => [];
}

class FirebaseLoadItems extends FirebaseItemsEvent {}

class FirebaseItemsUpdated extends FirebaseItemsEvent {
  final List<FirebaseItem> items;

  const FirebaseItemsUpdated({required this.items});

  @override
  List<Object> get props => [items];
}
