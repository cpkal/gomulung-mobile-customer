import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/data/model/cartItem.dart';
import 'package:las_customer/presentation/bloc/sell_trash/sell_trash_bloc.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:las_customer/presentation/widget/orders/pick_location.dart';

class SellTrashPage extends StatefulWidget {
  @override
  _SellTrashPageState createState() => _SellTrashPageState();
}

class _SellTrashPageState extends State<SellTrashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchTrashes();
  }

  void _fetchTrashes() async {
    context.read<SellTrashBloc>().add(FetchTrashTypes());
  }

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PickLocation(),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SellTrashBloc, SellTrashState>(
                    builder: (context, state) {
                      if (state.loading == true) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return OrderCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildOptions(state.cartItems ?? []),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
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
                      children: [
                        BlocBuilder<SellTrashBloc, SellTrashState>(
                          builder: (context, state) {
                            return Text('Rp.' + state.totalPrice.toString());
                          },
                        ),
                        Text('|'),
                        Text('Jual')
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOptions(List<CartItem>? cartItems) {
    String prevType = '';
    return cartItems!.map((e) {
      if (prevType != e.trash.trashType) {
        prevType = e.trash.trashType!;
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                e.trash.trashType!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.trash.subTrashType! +
                            '/' +
                            e.trash.unitOfMeasurement!),
                        Text('Rp. ' + e.trash.priceForMember.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context.read<SellTrashBloc>().add(
                                  UpdateQty(
                                      e.trash,
                                      context
                                              .read<SellTrashBloc>()
                                              .state
                                              .cartItems!
                                              .firstWhere((element) =>
                                                  element.trash.id ==
                                                  e.trash.id)
                                              .quantity! -
                                          1),
                                );
                          },
                        ),
                        Text(
                          context
                              .read<SellTrashBloc>()
                              .state
                              .cartItems!
                              .firstWhere(
                                  (element) => element.trash.id == e.trash.id)
                              .quantity
                              .toString(),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context.read<SellTrashBloc>().add(UpdateQty(
                                e.trash,
                                context
                                        .read<SellTrashBloc>()
                                        .state
                                        .cartItems!
                                        .firstWhere((element) =>
                                            element.trash.id == e.trash.id)
                                        .quantity! +
                                    1));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      } else
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.trash.subTrashType! +
                          '/' +
                          e.trash.unitOfMeasurement!),
                      Text('Rp. ' + e.trash.priceForMember.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          context.read<SellTrashBloc>().add(UpdateQty(
                              e.trash,
                              context
                                      .read<SellTrashBloc>()
                                      .state
                                      .cartItems!
                                      .firstWhere((element) =>
                                          element.trash.id == e.trash.id)
                                      .quantity! -
                                  1));
                        },
                      ),
                      Text(
                        context
                            .read<SellTrashBloc>()
                            .state
                            .cartItems!
                            .firstWhere(
                                (element) => element.trash.id == e.trash.id)
                            .quantity
                            .toString(),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          context.read<SellTrashBloc>().add(UpdateQty(
                              e.trash,
                              context
                                      .read<SellTrashBloc>()
                                      .state
                                      .cartItems!
                                      .firstWhere((element) =>
                                          element.trash.id == e.trash.id)
                                      .quantity! +
                                  1));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        );
    }).toList();
  }
}
