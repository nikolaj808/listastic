import 'package:flutter/material.dart';

class LoadingButtonController {
  late VoidCallback startListener;
  late VoidCallback stopListener;
  late VoidCallback successListener;
  late VoidCallback errorListener;
  late VoidCallback resetListener;
}

class LoadingButton extends StatefulWidget {
  final BuildContext context;
  final void Function() onTap;

  // ignore: sort_constructors_first
  const LoadingButton({
    Key? key,
    required this.context,
    required this.onTap,
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  double width = 160.0;
  double height = 48.0;

  late Widget childState = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        child: Text(
          'Tilføj vare',
          style: Theme.of(widget.context).primaryTextTheme.button,
        ),
      ),
      const SizedBox(width: 8.0),
      Icon(
        Icons.done,
        color: Theme.of(context).primaryIconTheme.color,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 600),
      width: width,
      height: height,
      child: Material(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: () {
            widget.onTap();

            setState(() {
              width = 48;

              Future.delayed(const Duration(milliseconds: 300), () {
                setState(() {
                  childState = SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                });
              });
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: childState,
          ),
        ),
      ),
    );
  }
}
