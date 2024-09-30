import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class ShowRingkasanAngkutan extends StatelessWidget {
  // final Function() onTap;

  // const ShowRingkasanAngkutan({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OrderCard(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Angkutan',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),

          //organic trash 2kg price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space evenly
            children: [
              Text('Berat sampah Kecil (maks 5kg)'),
              Text('Rp. 2.000'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space evenly
            children: [
              Text('Biaya angkut'),
              Text('Rp. 6.000'),
            ],
          ),
          //line separator dot
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //space evenly
            children: [
              Text('Total Bayar'),
              Text('Rp. 8.000'),
            ],
          ),
        ],
      ),
    );
  }
}
