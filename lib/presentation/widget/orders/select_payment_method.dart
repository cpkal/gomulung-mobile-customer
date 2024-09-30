import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class SelectPaymentMethod extends StatelessWidget {
  final Function() onTap;

  const SelectPaymentMethod({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OrderCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.attach_money),
              SizedBox(
                width: 10,
              ),
              Text(
                'Metode pembayaran',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text('TUNAI', style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
