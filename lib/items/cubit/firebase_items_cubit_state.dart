part of 'firebase_items_cubit.dart';

abstract class FirebaseItemsCubitState extends Equatable {
  const FirebaseItemsCubitState();

  @override
  List<Object> get props => [];
}

class FirebaseItemsIdle extends FirebaseItemsCubitState {}

class FirebaseItemCreating extends FirebaseItemsCubitState {}

class FirebaseItemCreateSuccess extends FirebaseItemsCubitState {}

class FirebaseItemUpdating extends FirebaseItemsCubitState {}

class FirebaseItemUpdateSuccess extends FirebaseItemsCubitState {}

class FirebaseItemError extends FirebaseItemsCubitState {
  final String message;

  FirebaseItemError({required this.message});

  @override
  List<Object> get props => [message];
}
