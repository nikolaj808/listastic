import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:listastic/items/bloc/items_bloc.dart';
import 'package:listastic/models/item.dart';

class ListItem extends StatelessWidget {
  final Item item;

  // ignore: sort_constructors_first
  const ListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id!),
      background: Container(color: Theme.of(context).errorColor),
      onDismissed: (_) {
        BlocProvider.of<ItemsBloc>(context).add(DeleteItem(item: item));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text('x${item.quantity}'),
        ),
        title: Text(item.name),
        subtitle: Text('Tilføjet af: ${item.userId}'),
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
