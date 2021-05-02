part of 'shoppinglist_details_bloc.dart';

abstract class ShoppinglistDetailsEvent extends Equatable {
  const ShoppinglistDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetShoppinglistDetails extends ShoppinglistDetailsEvent {
  final String shoppinglistId;

  GetShoppinglistDetails({required this.shoppinglistId});

  @override
  List<Object> get props => [shoppinglistId];
}
