import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/bloc/sqflite_items_bloc.dart';
import 'package:listastic/items/view/widgets/no_items.dart';
import 'package:listastic/items/view/widgets/sqflite_items_list.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';

class SqfliteItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SqfliteItemsBloc, SqfliteItemsState>(
        builder: (context, state) {
          if (state is SqfliteItemsLoaded) {
            final items = state.items;

            return SqfliteItemsList(items: items);
          }

          if (state is SqfliteItemsError) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Der skete en fejl..',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      final currentState =
                          context.read<ModeCubit>().state as ModeOffline;

                      context.read<SqfliteItemsBloc>().add(
                          SqfliteLoadItems(shoppinglistId: currentState.id));
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Genindlæs'),
                  ),
                  const SizedBox(height: 24.0),
                  const Text('Fejlbesked:'),
                  const SizedBox(height: 8.0),
                  Text(
                    state.message,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            );
          }

          if (state is SqfliteItemsEmpty) {
            return NoItems();
          }

          return LoadingStateFiller();
        },
      ),
    );
  }
}
