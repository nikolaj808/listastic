import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listastic/items/view/widgets/create_item_form.dart';
import 'package:listastic/shoppinglists/view/shoppinglists_page.dart';
import 'package:supercharged/supercharged.dart';
import 'package:listastic/items/items.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

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
        title: const Text('Min indkøbsliste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
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
            return CreateItemForm();
          },
        ),
        child: const Icon(Icons.add),
      ),
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
        onPageChanged: (index) => setState(() => _currentPageIndex = index),
        children: [
          ItemsPage(),
          ShoppinglistsPage(),
        ],
      ),
    );
  }
}
