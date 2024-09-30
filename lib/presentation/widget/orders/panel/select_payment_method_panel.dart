import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/panel/order_panel.dart';

class SelectPaymentMethodPanel extends StatelessWidget {
  final Function() onPressed;

  const SelectPaymentMethodPanel({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OrderPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mau bayar pake apa nih?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Pilih metode pembayaran yang paling mudah buat kamu',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey.shade400))
                  ],
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.close),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //select payment method
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.attach_money_outlined),
                SizedBox(
                  width: 5,
                ),
                Text('Tunai',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
                    width: 75)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
