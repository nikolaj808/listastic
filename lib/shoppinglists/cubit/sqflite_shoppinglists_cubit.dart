import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/shoppinglists/repository/sqflite_shoppinglists_repository.dart';

part 'sqflite_shoppinglists_cubit_state.dart';

class SqfliteShoppinglistsCubit extends Cubit<SqfliteShoppinglistsState> {
  final SqfliteShoppinglistsRepository shoppinglistsRepository;

  SqfliteShoppinglistsCubit({required this.shoppinglistsRepository})
      : super(ShoppinglistsInitial());
}
