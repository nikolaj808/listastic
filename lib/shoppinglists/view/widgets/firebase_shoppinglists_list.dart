import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/bloc/firebase_items_bloc.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shared_preferences/service/shared_preferences_service.dart';
import 'package:listastic/shoppinglists/bloc/firebase_shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/view/widgets/firebase_shoppinglist_list_item.dart';
import 'package:supercharged/supercharged.dart';

class FirebaseShoppinglistsList extends StatelessWidget {
  final PageController pageController;

  const FirebaseShoppinglistsList({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  Future<void> _onItemTapped(
    BuildContext context,
    FirebaseShoppinglist shoppinglist,
  ) async {
    context.read<ModeCubit>().setMode(ModeOnline(id: shoppinglist.id!));

    await SharedPreferencesService().setLatestOnline(shoppinglist.id!);

    context.read<FirebaseItemsBloc>().add(FirebaseLoadItems());

    return pageController.animateToPage(
      0,
      duration: (0.5).seconds,
      curve: Curves.easeInOut,
    );
  }

  void _onEditPressed(BuildContext context, FirebaseShoppinglist shoppinglist) {
    Navigator.of(context).pushNamed(
      'shoppinglist-details',
      arguments: shoppinglist.id ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseShoppinglistsBloc, FirebaseShoppinglistsState>(
      builder: (context, state) {
        if (state is FirebaseShoppinglistsLoaded) {
          final shoppinglists = state.shoppinglists;

          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: shoppinglists
                  .map(
                    (shoppinglist) => BlocBuilder<ModeCubit, ModeState>(
                        builder: (context, state) {
                      return FirebaseShoppinglistListItem(
                        state: state,
                        shoppinglist: shoppinglist,
                        onTap: () => _onItemTapped(context, shoppinglist),
                        onEditPressed: () =>
                            _onEditPressed(context, shoppinglist),
                      );
                    }),
                  )
                  .toList(),
            ),
          );
        }

        if (state is FirebaseShoppinglistsEmpty) {
          return Center(
            child: Text(
              'Ingen shoppinglists..',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
          );
        }

        return LoadingStateFiller();
      },
    );
  }
}
