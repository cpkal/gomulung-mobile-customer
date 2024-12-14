import 'package:flutter/material.dart';

class OrderPanel extends StatelessWidget {
  final Widget child;
  final heightRatio;

  const OrderPanel({required this.child, this.heightRatio});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * (heightRatio ?? 0.75),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          //border radius top right and left top
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          //border grey
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Container(padding: EdgeInsets.all(30), child: child),
      ),
    );
  }
}
