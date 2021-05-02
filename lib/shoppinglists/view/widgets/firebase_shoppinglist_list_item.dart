import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/users/cubit/users_cubit.dart';

class FirebaseShoppinglistListItem extends StatelessWidget {
  final ModeState state;
  final FirebaseShoppinglist shoppinglist;
  final void Function() onTap;
  final void Function() onEditPressed;

  const FirebaseShoppinglistListItem({
    Key? key,
    required this.state,
    required this.shoppinglist,
    required this.onTap,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentState = state;

    if (currentState is ModeOnline && currentState.id == shoppinglist.id) {
      return FutureBuilder<ListasticUser>(
          future: BlocProvider.of<UsersCubit>(context)
              .getUserById(shoppinglist.ownerId),
          builder: (context, snapshot) {
            final owner = snapshot.data;

            return ListTile(
              enabled: false,
              tileColor: Theme.of(context).primaryColor,
              title: Text(
                shoppinglist.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              ),
              subtitle: owner != null
                  ? Text(
                      owner.displayName ?? 'Listastic bruger',
                      style: const TextStyle().copyWith(
                        color: Colors.white,
                      ),
                    )
                  : LoadingStateFiller(),
              trailing: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.edit),
                onPressed: onEditPressed,
              ),
            );
          });
    }

    return FutureBuilder<ListasticUser>(
        future: BlocProvider.of<UsersCubit>(context)
            .getUserById(shoppinglist.ownerId),
        builder: (context, snapshot) {
          final owner = snapshot.data;

          return ListTile(
            onTap: onTap,
            leading: const Icon(Icons.chevron_left),
            title: Text(
              shoppinglist.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: owner != null
                ? Text(owner.displayName ?? 'Listastic bruger')
                : LoadingStateFiller(),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditPressed,
            ),
          );
        });
  }
}
