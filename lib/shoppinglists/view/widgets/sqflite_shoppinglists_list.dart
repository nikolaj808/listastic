import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shared_preferences/service/shared_preferences_service.dart';
import 'package:listastic/shoppinglists/bloc/sqflite_shoppinglists_bloc.dart';
import 'package:supercharged/supercharged.dart';

class SqfliteShoppinglistsList extends StatelessWidget {
  final PageController pageController;

  // ignore: sort_constructors_first
  const SqfliteShoppinglistsList({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SqfliteShoppinglistsBloc, SqfliteShoppinglistsState>(
      builder: (context, state) {
        if (state is SqfliteShoppinglistsLoaded) {
          final shoppinglists = state.shoppinglists;

          return Column(
            children: shoppinglists
                .map(
                  (shoppinglist) => BlocBuilder<ModeCubit, ModeState>(
                    builder: (context, state) {
                      if (state is ModeOffline && state.id == shoppinglist.id) {
                        return ListTile(
                          onTap: () {},
                          tileColor: Theme.of(context).primaryColor,
                          title: Text(
                            shoppinglist.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.white),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                Jiffy(shoppinglist.lastModifiedAt)
                                    .format('dd/MM/yy'),
                                style: const TextStyle().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                Jiffy(shoppinglist.lastModifiedAt).Hm,
                                style: const TextStyle().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListTile(
                        onTap: () {
                          context
                              .read<ModeCubit>()
                              .setMode(ModeOffline(id: shoppinglist.id!));
                          SharedPreferencesService()
                              .setLatestOffline(shoppinglist.id!);

                          pageController.animateToPage(
                            0,
                            duration: (0.5).seconds,
                            curve: Curves.easeInOut,
                          );
                        },
                        leading: const Icon(Icons.chevron_left),
                        title: Text(
                          shoppinglist.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(Jiffy(shoppinglist.lastModifiedAt)
                                .format('dd/MM/yy')),
                            Text(Jiffy(shoppinglist.lastModifiedAt).Hm),
                          ],
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        }

        if (state is SqfliteShoppinglistsEmpty) {
          const Text('Ingen shoppinglists');
        }

        return LoadingStateFiller();
      },
    );
  }
}
