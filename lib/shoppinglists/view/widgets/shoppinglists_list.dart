import 'package:flutter/material.dart';
import 'package:listastic/models/shoppinglist.dart';
import 'package:listastic/shoppinglists/view/widgets/list_shoppinglist.dart';

abstract class IShoppinglistListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget? buildSubtitle(BuildContext context);
}

class ShoppinglistHeadingItem implements IShoppinglistListItem {
  final String heading;

  // ignore: sort_constructors_first
  ShoppinglistHeadingItem({required this.heading});

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget? buildSubtitle(BuildContext context) => null;
}

class ShoppinglistListItem implements IShoppinglistListItem {
  final String sender;
  final String body;

  // ignore: sort_constructors_first
  ShoppinglistListItem({
    required this.sender,
    required this.body,
  });

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget? buildSubtitle(BuildContext context) => Text(body);
}

class ShoppinglistsList extends StatelessWidget {
  final Shoppinglist personalShoppinglist = Shoppinglist(
    name: 'Min indkøbsliste',
    ownerId: 'Mig',
    createdAt: DateTime.now(),
    lastModifiedAt: DateTime.now(),
  );
  final List<Shoppinglist> shoppinglists;

  // ignore: sort_constructors_first
  ShoppinglistsList({
    Key? key,
    required this.shoppinglists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final combinedShoppingLists = List<IShoppinglistListItem>.from([
      ShoppinglistHeadingItem(heading: 'Personlige indkøbslister'),
      ShoppinglistListItem(
        sender: personalShoppinglist.name,
        body: personalShoppinglist.ownerId,
      ),
      ShoppinglistHeadingItem(heading: 'Delte indkøbslister'),
      ...shoppinglists
          .map((shoppinglist) => ShoppinglistListItem(
              sender: shoppinglist.name, body: shoppinglist.ownerId))
          .toList(),
    ]);

    return ListView.builder(
      itemCount: combinedShoppingLists.length,
      itemBuilder: (context, index) {
        final item = combinedShoppingLists[index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 16.0),
          Text(
            'Dine personlige indkøbslister',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16.0),
          ListShoppinglist(shoppinglist: shoppinglists.first),
          const SizedBox(height: 32.0),
          Text(
            'Dine delte indkøbslister',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 16.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: shoppinglists
                .map((shoppinglist) =>
                    ListShoppinglist(shoppinglist: shoppinglist))
                .toList(),
          ),
        ],
      ),
    );
    return ListView.builder(
      itemCount: shoppinglists.length,
      padding: const EdgeInsets.only(bottom: 64.0),
      itemBuilder: (context, index) {
        final shoppinglist = shoppinglists[index];

        return ListShoppinglist(shoppinglist: shoppinglist);
      },
    );
  }
}
