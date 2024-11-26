import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/data/model/trash.dart';
import 'package:las_customer/presentation/bloc/sell_trash/sell_trash_bloc.dart';
import 'package:las_customer/presentation/widget/orders/order_card.dart';
import 'package:las_customer/presentation/widget/orders/pick_location.dart';
import 'package:las_customer/presentation/widget/orders/select_payment_method.dart';

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
                  SelectPaymentMethod(onTap: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SellTrashBloc, SellTrashState>(
                    builder: (context, state) {
                      if (state is SellTrashLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SellTrashLoaded) {
                        return OrderCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildOptions(state.trashes),
                          ),
                        );
                      } else if (state is SellTrashSelected) {
                        return OrderCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildOptions(state.trashes),
                          ),
                        );
                      } else if (state is SellTrashError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Container();
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
                      children: [Text('Rp. 8.000'), Text('|'), Text('Jual')],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOptions(List<Trash> trashes) {
    String prevType = '';
    return trashes.map((e) {
      if (prevType != e.trashType) {
        prevType = e.trashType!;
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                e.trashType!,
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
                        Text(e.subTrashType! + '/' + e.unitOfMeasurement!),
                        Text('Rp. ' + e.priceForMember.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context
                                .read<SellTrashBloc>()
                                .add(UpdateQty(trashes, e, -1));
                          },
                        ),
                        Text('0'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context
                                .read<SellTrashBloc>()
                                .add(UpdateQty(trashes, e, 1));
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
                      Text(e.subTrashType! + '/' + e.unitOfMeasurement!),
                      Text('Rp. ' + e.priceForMember.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          context
                              .read<SellTrashBloc>()
                              .add(UpdateQty(trashes, e, -1));
                        },
                      ),
                      Text('0'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          context
                              .read<SellTrashBloc>()
                              .add(UpdateQty(trashes, e, 1));
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
