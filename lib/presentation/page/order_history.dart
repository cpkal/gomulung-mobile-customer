import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:las_customer/core/util/helper.dart';
import 'package:las_customer/main.dart';
import 'package:las_customer/presentation/bloc/order/order_bloc.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderBloc>().add(FetchFinishedOrders());
  }

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
              child: Text('Kamu belum memiliki pesanan selesai'),
            );
          }

          if (state is OrdersLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  for (var order in state.orders)
                    GestureDetector(
                      onTap: () {},
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
                                  toRupiah(int.parse(order.order!.grandTotal!)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // badge status
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color:
                                            order.order!.status! == 'completed'
                                                ? Colors.green
                                                : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Text(
                                        order.order!.status! == 'completed'
                                            ? 'Selesai'
                                            : 'Dibatalkan',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
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
                            Text('Dipesan pada ' +
                                DateFormat('dd MMMM yyyy hh:mm').format(
                                    stringToDateTime(order.order!.createdAt!))),

                            Text(
                              order.order!.paymentMethod == 'tunai'
                                  ? 'Pembayaran tunai'
                                  : 'Pembayaran non-tunai',
                            ),
                            //
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
