import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:listastic/models/shoppinglist.dart';
import 'package:listastic/shoppinglists/repository/shoppinglists_repository.dart';
import 'package:pedantic/pedantic.dart';

part 'shoppinglists_event.dart';
part 'shoppinglists_state.dart';

class ShoppinglistsBloc extends Bloc<ShoppinglistsEvent, ShoppinglistsState> {
  final ShoppinglistsRepository shoppinglistsRepository;
  StreamSubscription? _shoppinglistsSubscription;

  // ignore: sort_constructors_first
  ShoppinglistsBloc({required this.shoppinglistsRepository})
      : super(ShoppinglistsInitial());

  @override
  Stream<ShoppinglistsState> mapEventToState(
    ShoppinglistsEvent event,
  ) async* {
    if (event is LoadShoppinglists) {
      yield* _mapLoadShoppinglistsToState();
    } else if (event is ShoppinglistsUpdated) {
      yield* _mapShoppinglistsUpdatedToState(event);
    } else if (event is CreateShoppinglist) {
      yield* _mapCreateShoppinglistToState(event);
    } else if (event is UpdateShoppinglist) {
      yield* _mapUpdateShoppinglistToState(event);
    } else if (event is DeleteShoppinglist) {
      yield* _mapDeleteShoppinglistToState(event);
    }
  }

  Stream<ShoppinglistsState> _mapLoadShoppinglistsToState() async* {
    yield ShoppinglistsLoading();

    await _shoppinglistsSubscription?.cancel();
    _shoppinglistsSubscription =
        shoppinglistsRepository.getShoppinglists().listen(
              (shoppinglists) =>
                  add(ShoppinglistsUpdated(shoppinglists: shoppinglists)),
            );
  }

  Stream<ShoppinglistsState> _mapShoppinglistsUpdatedToState(
      ShoppinglistsUpdated event) async* {
    yield ShoppinglistsLoaded(shoppinglists: event.shoppinglists);
  }

  Stream<ShoppinglistsState> _mapCreateShoppinglistToState(
      CreateShoppinglist event) async* {
    unawaited(shoppinglistsRepository.createShoppinglist(event.shoppinglist));
  }

  Stream<ShoppinglistsState> _mapUpdateShoppinglistToState(
      UpdateShoppinglist event) async* {
    unawaited(shoppinglistsRepository.updateShoppinglist(event.shoppinglist));
  }

  Stream<ShoppinglistsState> _mapDeleteShoppinglistToState(
      DeleteShoppinglist event) async* {
    unawaited(shoppinglistsRepository.deleteShoppinglist(event.shoppinglist));
  }

  @override
  Future<void> close() {
    _shoppinglistsSubscription?.cancel();
    return super.close();
  }
}
