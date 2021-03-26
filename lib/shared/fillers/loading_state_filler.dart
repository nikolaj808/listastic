import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingStateFiller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 64,
        width: 64,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
