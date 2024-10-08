import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/page/detail_order_process.dart';
import 'package:las_customer/presentation/page/find_driver.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class OrderProcessPage extends StatelessWidget {
  OrderProcessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan kamu'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrdersEmpty) {
            return const Center(
              child: Text('Kamu belum memiliki pesanan'),
            );
          }

          if (state is OrdersLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  for (var order in state.orders)
                    GestureDetector(
                      onTap: () {
                        print(order.status);
                        if (order.status == 'pending') {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: FindDriverPage(
                              order: order,
                            ),
                          );
                        } else if (order.status == 'in_progress') {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: DetailOrderProcess(
                              order: order,
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        //border radius
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order.grandTotal.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Driver. Jajang Noer'),
                                    Text('B 1234 ABC'),
                                  ],
                                )
                              ],
                            ),

                            //border separator
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 1,
                              color: Colors.grey,
                            ),
                            //menuju lokasi
                            Text('Driver sedang menuju lokasi kamu'),
                          ],
                        ),
                      ),
                    ),

                  // Container(
                  //   //border radius
                  //   width: MediaQuery.of(context).size.width,
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       color: Colors.grey,
                  //       width: 1,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Rp. 10.000',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .headlineMedium!
                  //                 .copyWith(fontWeight: FontWeight.bold),
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [Text('Sedang mencari driver')],
                  //           )
                  //         ],
                  //       ),

                  //       //border separator
                  //       Container(
                  //         margin: EdgeInsets.symmetric(vertical: 10),
                  //         height: 1,
                  //         color: Colors.grey,
                  //       ),
                  //       //menuju lokasi
                  //       Text('Driver kamu belum ketemu nih, sabar ya'),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
