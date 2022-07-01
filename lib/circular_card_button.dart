import 'package:flutter/material.dart';

class CircularCardButton extends StatelessWidget {
  const CircularCardButton(
      {Key? key, required this.child, this.radius = 50, this.onTap})
      : super(key: key);

  final Widget child;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
          shape: const CircleBorder(),
          elevation: 5,
          child: Container(
              height: radius,
              width: radius,
              decoration: BoxDecoration(
                  color: Colors.pink[50],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.pink.shade100, blurRadius: 20)
                  ]),
              child: child),
        ),
        onTap: onTap ??
            () {
              debugPrint("Pressed Button");
            });
  }
}
