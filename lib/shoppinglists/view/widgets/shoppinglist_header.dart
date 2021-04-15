import 'package:flutter/material.dart';

class ShoppinglistHeader extends StatelessWidget {
  final String title;

  // ignore: sort_constructors_first
  const ShoppinglistHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListTile(
        title: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
