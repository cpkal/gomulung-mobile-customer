import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:las_customer/presentation/widget/orders/panel/order_panel.dart';
import 'package:las_customer/presentation/widget/orders/pick_location.dart';
import 'package:las_customer/presentation/widget/orders/show_ringkasan_angkutan.dart';

class SellTrashPage extends StatefulWidget {
  @override
  _SellTrashPageState createState() => _SellTrashPageState();
}

class _SellTrashPageState extends State<SellTrashPage> {
  bool isSelectTrashPanelOpen = false;

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
                        setState(() {
                          isSelectTrashPanelOpen = true;
                        });
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

          //select trash panel
          if (isSelectTrashPanelOpen) _buildSelectTrashPanel(),
        ],
      ),
    );
  }

  Widget _buildSelectTrashPanel() {
    return OrderPanel(
      heightRatio: 0.8,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //close button

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sampah Plastik',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSelectTrashPanelOpen = false;
                    });
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //list view sampah-sampah plastik
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: OrderCard(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.shopping_bag_rounded),
                      Text('Gelas minuman bening'),
                      Row(
                        children: [
                          //increment and decrement
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove),
                          ),
                          Text('1 Kg'),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ],
                      )
                    ],
                  )),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Sampah Kertas',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            //list view sampah-sampah plastik
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return OrderCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('PET Botol'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('1 Kg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Rp. 8.000'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Text(
              'Sampah Logam',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            //list view sampah-sampah plastik
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return OrderCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('PET Botol'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('1 Kg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Rp. 8.000'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Text(
              'Sampah Kaca',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            //list view sampah-sampah plastik
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return OrderCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('PET Botol'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('1 Kg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Rp. 8.000'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Text(
              'Sampah Lainnya',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            //list view sampah-sampah plastik
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return OrderCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('PET Botol'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('1 Kg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Rp. 8.000'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
