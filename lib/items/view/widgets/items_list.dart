import 'package:flutter/material.dart';
import 'package:listastic/items/view/widgets/list_item.dart';
import 'package:listastic/models/item.dart';

class ItemsList extends StatelessWidget {
  final List<Item> items;

  // ignore: sort_constructors_first
  const ItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListItem(item: item);
      },
    );
  }
}
