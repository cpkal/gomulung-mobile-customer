import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:las_customer/presentation/widget/orders/show_ringkasan_angkutan.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ExchangePointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Tukar Poin'),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tukar Poin',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  Text('Poin Anda: 1000'),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Jumlah Poin',
                    ),
                  ),
                  // bank tujuan
                  SizedBox(
                    height: 20,
                  ),
                  // dropdown buttons for bank options
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    items: [
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('Bank BCA'),
                        ),
                        value: 'bca',
                      ),
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('Bank Mandiri'),
                        ),
                        value: 'mandiri',
                      ),
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('Bank BNI'),
                        ),
                        value: 'bni',
                      ),
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('Bank BRI'),
                        ),
                        value: 'bri',
                      ),
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('OVO'),
                        ),
                        value: 'ovo',
                      ),
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('DANA'),
                        ),
                        value: 'dana',
                      ),
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('GoPay'),
                        ),
                        value: 'gopay',
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Bank Tujuan',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Atas Nama',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nomor Rekening / Nomor Handphone',
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              //center
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    //pop
                    PersistentNavBarNavigator.pop(context);
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('Tukar Poin')],
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
