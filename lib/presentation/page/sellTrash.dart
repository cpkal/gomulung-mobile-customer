import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:las_customer/presentation/widget/orders/pick_location.dart';
import 'package:las_customer/presentation/widget/orders/show_ringkasan_angkutan.dart';

class SellTrashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Jual Sampah'),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                PickLocation(),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            //add top left border radius
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('Jenis Sampah'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text('Berat Sampah'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            //add top right border radius
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10)),
                            ),
                            child: const Text('Harga Sampah'),
                          ),
                        )
                      ],
                    ),
//container row of trash
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'PET Botol',
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '1 Kg',
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Rp. 8.000',
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //button add trash
                    ElevatedButton(
                      onPressed: () {
                        //add new row of trash
                      },
                      child: Icon(Icons.add),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ShowRingkasanAngkutan(),
                  ],
                )
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
                onPressed: () {},
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Rp. 8.000'), Text('|'), Text('Jual')],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
