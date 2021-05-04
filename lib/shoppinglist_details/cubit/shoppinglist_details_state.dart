part of 'shoppinglist_details_cubit.dart';

abstract class ShoppinglistDetailsCubitState extends Equatable {
  const ShoppinglistDetailsCubitState();

  @override
  List<Object> get props => [];
}

class ShoppinglistDetailsInitial extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsCreatingShoppinglist
    extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsCreateShoppinglistSuccess
    extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsCreateShoppinglistError
    extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsAddingUser extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsUserAddSuccess extends ShoppinglistDetailsCubitState {}

class ShoppinglistDetailsUserAddError extends ShoppinglistDetailsCubitState {
  final String message;

  ShoppinglistDetailsUserAddError({required this.message});

  @override
  List<Object> get props => [message];
}
