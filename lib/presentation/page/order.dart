import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/model/repository/authentication_repository.dart';
import 'package:las_customer/presentation/bloc/map/map_bloc.dart';
import 'package:las_customer/presentation/page/map.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late bool _showPaymentMethod = false;
  List<bool> selectedSmartTrash = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LAS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigator.pushNamed(context, RoutePaths.myAccount);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MapPage(toDo: 'PICK_LOCATION'),
                        withNavBar: false,
                      );
                    },
                    child: Row(
                      children: [
                        //container circle dot
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BlocBuilder<MapBloc, MapState>(
                          builder: (context, state) {
                            if (state is MapPositionUpdate) {
                              return Flexible(
                                child: Text(
                                  state.position.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              );
                            } else {
                              return Text(
                                'Lokasi Anda',
                                style: Theme.of(context).textTheme.bodyLarge,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //grid 5 items
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  // height: 130,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => setState(() {
                                selectedSmartTrash[index] =
                                    !selectedSmartTrash[index];
                              }),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: selectedSmartTrash[index]
                                      ? Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2)
                                      : Border.all(
                                          color: Colors.grey,
                                        ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: Image.network(
                                    'https://img.freepik.com/free-vector/round-leaves-organic-circle_78370-2370.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showPaymentMethod = !_showPaymentMethod;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.money),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Text(
                                //   'TUNAI',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyLarge
                                //       ?.copyWith(fontWeight: FontWeight.bold),
                                // ),

                                Image.network(
                                  'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
                                  width: 100,
                                  //fit
                                  fit: BoxFit.fitWidth,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //map container with border
                        //price calculation overview
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, //space evenly
                                children: [
                                  Text('Sampah Organik 2kg'),
                                  Text('Rp. 2.000'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, //space evenly
                                children: [
                                  Text('Sampah Anorganik 2kg'),
                                  Text('Rp. 3.000'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, //space evenly
                                children: [
                                  Text('Sampah B3 2kg'),
                                  Text('Rp. 5.000'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //line separator dot
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, //space evenly
                                children: [
                                  Text('Biaya pembuangan'),
                                  Text('Rp. 10.000'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, //space evenly
                                children: [
                                  Text('Total Bayar'),
                                  Text('Rp. 20.000'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              //center
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    //push and remove all prev routes
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MapPage(toDo: 'ORDER'),
                      withNavBar: false,
                    );
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Rp. 10.000'),
                          Text('|'),
                          Text('Pesan')
                        ],
                      )),
                ),
              ),
            ),

            //panel to select payment method
            if (_showPaymentMethod) _buildPaymentMethodPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodPanel() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          //border radius top right and left top
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          //border grey
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PILIH METODE PEMBAYARAN",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  //close icon button
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showPaymentMethod = false;
                      });
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //select payment method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.money,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'TUNAI',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(),
                    child: Text('Pilih'),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //select payment method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(),
                    child: Text('Pilih'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
