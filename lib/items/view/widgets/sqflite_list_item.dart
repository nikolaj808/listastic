import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:listastic/items/bloc/sqflite_items_bloc.dart';
import 'package:listastic/models/item/sqflite_item.dart';

class SqfliteListItem extends StatelessWidget {
  final SqfliteItem item;

  const SqfliteListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id!.toString()),
      background: Container(color: Theme.of(context).errorColor),
      onDismissed: (_) {
        context.read<SqfliteItemsBloc>().add(SqfliteDeleteItem(item: item));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text('x${item.quantity}'),
        ),
        title: Text(item.name),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(Jiffy(item.lastModifiedAt).format('dd/MM/yy')),
            Text(Jiffy(item.lastModifiedAt).Hm),
          ],
        ),
      ),
    );
  }
}
