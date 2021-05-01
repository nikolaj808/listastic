part of 'shoppinglist_details_cubit.dart';

abstract class ShoppinglistDetailsCubitState extends Equatable {
  const ShoppinglistDetailsCubitState();

  @override
  List<Object> get props => [];
}

class ShoppinglistDetailsInitial extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsAddingUser extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsUserAddSuccess extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsUserAddError extends ShoppinglistDetailsCubitState {
  final String message;

  // ignore: sort_constructors_first
  ShoppinglistDetailsUserAddError({required this.message});

  @override
  List<Object> get props => [message];
}
