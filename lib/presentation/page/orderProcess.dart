import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';
import 'package:las_customer/presentation/page/map.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class OrderProcessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan kamu'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrdersUpdated) {
              return Column(
                children: [
                  //foreach order
                  for (var order in state.orders)
                    Container(
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
                                'Rp. 10.000',
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
                  SizedBox(height: 20),

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
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
