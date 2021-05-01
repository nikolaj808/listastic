import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shoppinglists/repository/firebase_shoppinglists_repository.dart';

part 'shoppinglist_details_event.dart';
part 'shoppinglist_details_state.dart';

class ShoppinglistDetailsBloc
    extends Bloc<ShoppinglistDetailsEvent, ShoppinglistDetailsState> {
  final FirebaseShoppinglistsRepository shoppinglistsRepository;

  // ignore: sort_constructors_first
  ShoppinglistDetailsBloc({
    required this.shoppinglistsRepository,
  }) : super(ShoppinglistDetailsInitial());

  @override
  Stream<ShoppinglistDetailsState> mapEventToState(
    ShoppinglistDetailsEvent event,
  ) async* {
    if (event is GetShoppinglistDetails) {
      yield* _mapGetShoppinglistDetailsToState(event);
    }
  }

  Stream<ShoppinglistDetailsState> _mapGetShoppinglistDetailsToState(
    GetShoppinglistDetails event,
  ) async* {
    final shoppinglistId = event.shoppinglistId;

    yield ShoppinglistDetailsLoading();

    try {
      final shoppinglist =
          await shoppinglistsRepository.getShoppinglist(shoppinglistId);

      yield ShoppinglistDetailsLoaded(shoppinglist: shoppinglist);
    } catch (e) {
      yield ShoppinglistDetailsError();
    }
  }
}
