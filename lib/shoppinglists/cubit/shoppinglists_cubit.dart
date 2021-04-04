import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/shoppinglists/repository/shoppinglists_repository.dart';
import 'package:pedantic/pedantic.dart';

part 'shoppinglists_cubit_state.dart';

class ShoppinglistsCubit extends Cubit<ShoppinglistsCubitState> {
  final ShoppinglistsRepository shoppinglistsRepository;

  // ignore: sort_constructors_first
  ShoppinglistsCubit({required this.shoppinglistsRepository})
      : super(ShoppinglistsInitial());

  Future<void> getShoppinglistById(String shoppinglistId) async {
    unawaited(shoppinglistsRepository.getShoppinglist(shoppinglistId));
  }
}
