import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/shoppinglists/bloc/firebase_shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/bloc/sqflite_shoppinglists_bloc.dart';

class HomeScaffoldTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCubit, ModeState>(
      builder: (context, modeState) {
        if (modeState is ModeOnline) {
          return BlocBuilder<FirebaseShoppinglistsBloc,
              FirebaseShoppinglistsState>(
            builder: (context, shoppinglistState) {
              if (shoppinglistState is FirebaseShoppinglistsLoaded) {
                final currentShoppinglist = shoppinglistState.shoppinglists
                    .where((shoppinglist) => shoppinglist.id == modeState.id)
                    .first;

                return Text(currentShoppinglist.name);
              }

              return LinearProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              );
            },
          );
        } else if (modeState is ModeOffline) {
          return BlocBuilder<SqfliteShoppinglistsBloc,
              SqfliteShoppinglistsState>(
            builder: (context, shoppinglistState) {
              if (shoppinglistState is SqfliteShoppinglistsLoaded) {
                final currentShoppinglist = shoppinglistState.shoppinglists
                    .where((shoppinglist) => shoppinglist.id == modeState.id)
                    .first;

                return Text(currentShoppinglist.name);
              }

              return LinearProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              );
            },
          );
        }

        return LinearProgressIndicator(
          backgroundColor: Theme.of(context).accentColor,
        );
      },
    );
  }
}
