import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listastic/items/bloc/firebase_items_bloc.dart';
import 'package:listastic/items/bloc/sqflite_items_bloc.dart';
import 'package:listastic/items/view/items_page.dart';
import 'package:listastic/items/view/widgets/create_firebase_item_form.dart';
import 'package:listastic/items/view/widgets/create_sqflite_item_form.dart';
import 'package:listastic/mode/cubit/mode_cubit.dart';
import 'package:listastic/shared_preferences/service/shared_preferences_service.dart';
import 'package:listastic/shoppinglist_details/view/widgets/create_firebase_shoppinglist_form.dart';
import 'package:listastic/shoppinglists/bloc/firebase_shoppinglists_bloc.dart';
import 'package:listastic/shoppinglists/bloc/sqflite_shoppinglists_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listastic/shoppinglists/view/shoppinglists_page.dart';
import 'package:supercharged/supercharged.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  late int _currentPageIndex;

  late Widget _floatingActionButton;

  @override
  void initState() {
    super.initState();

    _currentPageIndex = 0;

    _rebuildFloatingActionButton(0);

    _setInitialModeAndLoad();

    context.read<SqfliteShoppinglistsBloc>().add(SqfliteLoadShoppinglists());
    context.read<FirebaseShoppinglistsBloc>().add(FirebaseLoadShoppinglists());
  }

  Future<void> _setInitialModeAndLoad() async {
    final sharedPreferencesService = SharedPreferencesService();

    final shoppinglistId = await sharedPreferencesService.getLatest();

    if (shoppinglistId is String) {
      context.read<ModeCubit>().setMode(ModeOnline(id: shoppinglistId));
      context.read<FirebaseItemsBloc>().add(FirebaseLoadItems());
    } else {
      context.read<ModeCubit>().setMode(ModeOffline(id: shoppinglistId as int));
      context
          .read<SqfliteItemsBloc>()
          .add(SqfliteLoadItems(shoppinglistId: shoppinglistId));
    }
  }

  void _rebuildFloatingActionButton(int index) {
    if (index == 0) {
      setState(() {
        _floatingActionButton = FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            builder: (context) {
              return BlocBuilder<ModeCubit, ModeState>(
                builder: (context, state) {
                  if (state is ModeOffline) {
                    return CreateSqfliteItemForm();
                  }

                  return CreateFirebaseItemForm();
                },
              );
            },
          ),
          child: const Icon(Icons.add),
        );
      });
    } else {
      setState(() {
        _floatingActionButton = FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            builder: (context) {
              return const CreateFirebaseShoppinglistForm();
            },
          ),
          child: const Icon(Icons.add_shopping_cart),
        );
      });
    }
  }

  void _onProfileIconPressed({required BuildContext context}) {
    Scaffold.of(context).openDrawer();
  }

  Widget _buildProfileIcon({required BuildContext context}) {
    final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    if (photoUrl == null) {
      return IconButton(
        icon: CircleAvatar(
          child: Image.asset(
            'assets/no_profile_picture.png',
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
        onPressed: () => _onProfileIconPressed(context: context),
      );
    }

    return IconButton(
      icon: ClipOval(child: Image.network(photoUrl)),
      onPressed: () => _onProfileIconPressed(context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => _buildProfileIcon(context: context),
        ),
        title: BlocBuilder<ModeCubit, ModeState>(
          builder: (context, modeState) {
            if (modeState is ModeOnline) {
              return BlocBuilder<FirebaseShoppinglistsBloc,
                  FirebaseShoppinglistsState>(
                builder: (context, shoppinglistState) {
                  if (shoppinglistState is FirebaseShoppinglistsLoaded) {
                    final currentShoppinglist = shoppinglistState.shoppinglists
                        .where(
                            (shoppinglist) => shoppinglist.id == modeState.id)
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
                        .where(
                            (shoppinglist) => shoppinglist.id == modeState.id)
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
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
            _pageController.animateToPage(
              index,
              duration: (0.5).seconds,
              curve: Curves.easeInOut,
            );
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Varer',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Lister',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPageIndex = index);
          _rebuildFloatingActionButton(index);
        },
        children: [
          ItemsPage(),
          ShoppinglistsPage(pageController: _pageController),
        ],
      ),
    );
  }
}
