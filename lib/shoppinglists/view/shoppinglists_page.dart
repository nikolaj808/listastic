import 'package:flutter/material.dart';
import 'package:listastic/shoppinglists/view/widgets/firebase_shoppinglists_list.dart';
import 'package:listastic/shoppinglists/view/widgets/shoppinglist_header.dart';
import 'package:listastic/shoppinglists/view/widgets/sqflite_shoppinglists_list.dart';

class ShoppinglistsPage extends StatelessWidget {
  final PageController pageController;

  const ShoppinglistsPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ShoppinglistHeader(title: 'Dine indkøbslister'),
        SqfliteShoppinglistsList(pageController: pageController),
        const ShoppinglistHeader(title: 'Delte indkøbslister'),
        FirebaseShoppinglistsList(pageController: pageController),
      ],
    );
  }
}
