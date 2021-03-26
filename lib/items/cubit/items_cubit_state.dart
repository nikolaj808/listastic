part of 'items_cubit.dart';

abstract class ItemsCubitState extends Equatable {
  const ItemsCubitState();

  @override
  List<Object> get props => [];
}

class ItemsIdle extends ItemsCubitState {}

class ItemsMutating extends ItemsCubitState {}

class ItemsSuccess extends ItemsCubitState {}

class ItemsError extends ItemsCubitState {
  final String message;

  // ignore: sort_constructors_first
  ItemsError({required this.message});

  @override
  List<Object> get props => [message];
}
