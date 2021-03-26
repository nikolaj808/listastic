import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/items/bloc/items_bloc.dart';
import 'package:listastic/items/cubit/items_cubit.dart';
import 'package:listastic/items/view/widgets/items_list.dart';
import 'package:listastic/items/view/widgets/no_items.dart';
import 'package:listastic/models/item.dart';
import 'package:listastic/shared/fillers/loading_state_filler.dart';
import 'package:listastic/shared/loading_button.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: const Text('Min indkøbsliste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              builder: (context) {
                final size = MediaQuery.of(context).size;

                return Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        bottom: 32.0,
                        left: 24.0,
                        right: 24.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Tilføj ny vare',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Vare',
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        initialValue: '0',
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                          labelText: 'Antal',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              icon: const Icon(
                                                Icons.arrow_upward,
                                                size: 28.0,
                                              ),
                                              onPressed: () {}),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.arrow_downward,
                                                size: 28.0,
                                              ),
                                              onPressed: () {}),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          LoadingButton(
                            context: context,
                            onTap: () =>
                                BlocProvider.of<ItemsCubit>(context).createItem(
                              Item(
                                name: 'Rød pesto',
                                quantity: 1,
                                createdAt: DateTime.now(),
                                lastModifiedAt: DateTime.now(),
                                userId: '1',
                                shoppinglistId: '1',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsLoaded) {
            final items = state.items;

            return ItemsList(items: items);
          }

          if (state is ItemsEmpty) {
            return NoItems();
          }

          return LoadingStateFiller();
        },
      ),
    );
  }
}
