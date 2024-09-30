import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class SelectTotalWeight extends StatelessWidget {
  final Function() onTap;
  final state;

  const SelectTotalWeight({required this.onTap, required this.state});

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
              Icon(
                Icons.browse_gallery_rounded,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Berat total',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                  state.weight_type == 'Kecil'
                      ? 'Kecil 5kg'
                      : state.weight_type == 'Sedang'
                          ? 'Sedang 10kg'
                          : 'Besar 20kg',
                  style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                width: 5,
              ),
              //icon arrow next
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 12,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
