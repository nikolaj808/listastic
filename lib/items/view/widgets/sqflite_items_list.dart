import 'package:flutter/material.dart';
import 'package:listastic/items/view/widgets/sqflite_list_item.dart';
import 'package:listastic/models/item/sqflite_item.dart';

class SqfliteItemsList extends StatelessWidget {
  final List<SqfliteItem> items;

  // ignore: sort_constructors_first
  const SqfliteItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.only(bottom: 64.0),
      itemBuilder: (context, index) {
        final item = items[index];

        return SqfliteListItem(item: item);
      },
    );
  }
}
