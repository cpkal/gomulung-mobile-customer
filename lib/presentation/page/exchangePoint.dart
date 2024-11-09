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
                  SizedBox(
                    height: 20,
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
                  //grid  pilihan e-wallet
                  GridView.count(
                      crossAxisCount: 4,
                      //padding: EdgeInsets.all(10),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      shrinkWrap: true,
                      children: [
                        //e-wallet
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  "https://cdn.freelogovectors.net/wp-content/uploads/2023/10/gopay-logo-01-freelogovectors.net_.png"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  "https://cdn.freelogovectors.net/wp-content/uploads/2023/10/gopay-logo-01-freelogovectors.net_.png"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  "https://cdn.freelogovectors.net/wp-content/uploads/2023/10/gopay-logo-01-freelogovectors.net_.png"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  "https://cdn.freelogovectors.net/wp-content/uploads/2023/10/gopay-logo-01-freelogovectors.net_.png"),
                            ],
                          ),
                        ),
                      ]),
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
