import 'dart:io';

import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';

class TakePictureTrash extends StatelessWidget {
  File? image;
  final Function() onTap;

  TakePictureTrash({this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OrderCard(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.camera_alt,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Foto sampahmu (opsional)',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              // ignore: unnecessary_null_comparison
              image == null
                  ? Text(
                      'Ambil foto',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                    )
                  : Text(
                      'Ganti foto',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
              )
            ],
          )
        ],
      ),
    );
  }
}
