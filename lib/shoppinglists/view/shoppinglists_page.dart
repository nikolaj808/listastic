import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shoppinglists/bloc/shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/view/widgets/shoppinglists_list.dart';

class ShoppinglistsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ShoppinglistsBloc, ShoppinglistsState>(
        builder: (context, state) {
          if (state is ShoppinglistsLoaded) {
            final shoppinglists = state.shoppinglists;

            return ShoppinglistsList(shoppinglists: shoppinglists);
          }

          return LoadingStateFiller();
        },
      ),
    );
  }
}
