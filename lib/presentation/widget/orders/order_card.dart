import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Function()? onTap;
  final Widget child;

  const OrderCard({this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap:
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        // margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}
