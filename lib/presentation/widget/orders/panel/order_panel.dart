import 'package:flutter/material.dart';

class OrderPanel extends StatelessWidget {
  final Widget child;

  const OrderPanel({required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
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
