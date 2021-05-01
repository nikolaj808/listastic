part of 'shoppinglist_details_bloc.dart';

abstract class ShoppinglistDetailsState extends Equatable {
  const ShoppinglistDetailsState();

  @override
  List<Object> get props => [];
}

class ShoppinglistDetailsInitial extends ShoppinglistDetailsState {}

class ShoppinglistDetailsLoading extends ShoppinglistDetailsState {}

class ShoppinglistDetailsLoaded extends ShoppinglistDetailsState {
  final FirebaseShoppinglist shoppinglist;

  // ignore: sort_constructors_first
  ShoppinglistDetailsLoaded({required this.shoppinglist});

  @override
  List<Object> get props => [shoppinglist];
}

class ShoppinglistDetailsError extends ShoppinglistDetailsState {}
