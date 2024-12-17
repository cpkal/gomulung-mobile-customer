import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/point/point_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:las_customer/presentation/page/exchangePoint.dart';
import 'package:las_customer/presentation/page/order.dart';
import 'package:las_customer/presentation/page/sell_trash.dart';
import 'package:las_customer/presentation/widget/home/articleCard.dart';
import 'package:las_customer/presentation/widget/home/carousel.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPoint();
  }

  void _fetchPoint() {
    context.read<PointBloc>().add(FetchPoint());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png', height: 50),
          actions: [
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: ExchangePointPage(),
                  withNavBar: false,
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20, top: 3),
                child: Row(
                  children: [
                    Icon(Icons.confirmation_num_outlined,
                        color: Theme.of(context).primaryColor),
                    SizedBox(width: 8),
                    BlocBuilder<PointBloc, PointState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return CircularProgressIndicator();
                        }

                        return Text(state.point.toString());
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),

              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: BlocProvider.value(
                            value: context.read<WebsocketBloc>(),
                            child: OrderPage()),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pedal_bike_outlined,
                            size: 44,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'BUANG',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: SellTrashPage(),
                        withNavBar: false,
                      );

                      // // coming soon scaffold
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Feature coming soon!'),
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                        // add transparent color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 44,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'JUAL',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ExchangePointPage(),
                        withNavBar: false,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.confirmation_num_outlined,
                            size: 44,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'POIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Edukasi',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              //scrollable grid horizontal
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ArticleCard(
                      imageUrl:
                          'https://www.shutterstock.com/image-vector/4-types-trash-dispose-wheelie-260nw-1915169338.jpg',
                      title: 'Cara memilah sampah dengan benar',
                      excerpt:
                          'Memilah sampah dengan benar akan memudahkan proses daur ulang',
                    ),
                    ArticleCard(
                      imageUrl:
                          'https://dlh.semarangkota.go.id/wp-content/uploads/2021/02/Bank-sampah-image-nu.or_.id.jpg',
                      title: 'Manfaat Bank Sampah',
                      excerpt: 'Bank sampah membantu mengurangi sampah plastik',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
