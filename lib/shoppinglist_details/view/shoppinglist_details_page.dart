import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shared/snackbars/common_snackbar.dart';
import 'package:listastic/shoppinglist_details/bloc/shoppinglist_details_bloc.dart';
import 'package:listastic/shoppinglist_details/cubit/shoppinglist_details_cubit.dart';
import 'package:listastic/shoppinglist_details/view/widgets/add_user_form.dart';
import 'package:listastic/users/cubit/users_cubit.dart';

class ShoppinglistDetailsPage extends StatefulWidget {
  final String shoppinglistId;

  // ignore: sort_constructors_first
  const ShoppinglistDetailsPage({
    Key? key,
    required this.shoppinglistId,
  }) : super(key: key);

  @override
  _ShoppinglistDetailsPageState createState() =>
      _ShoppinglistDetailsPageState();
}

class _ShoppinglistDetailsPageState extends State<ShoppinglistDetailsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShoppinglistDetailsBloc>(context).add(
      GetShoppinglistDetails(shoppinglistId: widget.shoppinglistId),
    );
  }

  void _onAddUserPressed(
    BuildContext context,
    FirebaseShoppinglist shoppinglist,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      builder: (_) => AddUserForm(shoppinglist: shoppinglist),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppinglistDetailsBloc, ShoppinglistDetailsState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: state is ShoppinglistDetailsLoaded
              ? Text(state.shoppinglist.name)
              : const LinearProgressIndicator(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => state is ShoppinglistDetailsLoaded
              ? _onAddUserPressed(context, state.shoppinglist)
              : null,
          icon: const Icon(Icons.group_add),
          label: const Text('Tilføj bruger'),
        ),
        body: BlocListener<ShoppinglistDetailsCubit,
            ShoppinglistDetailsCubitState>(
          listener: (context, state) {
            if (state is ShoppinglistDetailsUserAddSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                CommonSnackbar.success('Bruger tilføjet til gruppen'),
              );
            }

            if (state is ShoppinglistDetailsUserAddError) {
              ScaffoldMessenger.of(context).showSnackBar(
                CommonSnackbar.error(state.message),
              );
            }
          },
          child: Builder(
            builder: (context) {
              if (state is ShoppinglistDetailsLoaded) {
                final shoppinglist = state.shoppinglist;

                return ListView(
                  children: [
                    FutureBuilder<ListasticUser>(
                      future: BlocProvider.of<UsersCubit>(context)
                          .getUserById(shoppinglist.ownerId),
                      builder: (context, snapshot) {
                        final owner = snapshot.data;

                        if (owner != null) {
                          return ListTile(
                            title: const Text('Indkøbsliste ejeren'),
                            subtitle: ListTile(
                              onTap: () {},
                              leading: owner.photoUrl != null
                                  ? ClipOval(
                                      child: Image.network(owner.photoUrl!),
                                    )
                                  : const Icon(Icons.account_circle),
                              title:
                                  Text(owner.displayName ?? 'Listastic bruger'),
                              subtitle: Text(owner.email ?? ''),
                            ),
                            leading: const Icon(Icons.perm_identity),
                          );
                        }

                        return LoadingStateFiller();
                      },
                    ),
                    ExpansionTile(
                      title: const Text('Indkøbsliste brugere'),
                      leading: const Icon(Icons.group),
                      children: [
                        ...shoppinglist.userIds
                            .map(
                              (userId) => FutureBuilder<ListasticUser>(
                                builder: (context, snapshot) {
                                  final user = snapshot.data;

                                  if (user != null) {
                                    return ListTile(
                                      onTap: () {},
                                      leading: user.photoUrl != null
                                          ? ClipOval(
                                              child:
                                                  Image.network(user.photoUrl!),
                                            )
                                          : const Icon(Icons.account_circle),
                                      title: Text(user.displayName ??
                                          'Listastic bruger'),
                                      subtitle: Text(user.email ?? ''),
                                    );
                                  }

                                  return LoadingStateFiller();
                                },
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ],
                );
              }

              return LoadingStateFiller();
            },
          ),
        ),
      ),
    );
  }
}
