import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/bloc/websocket/websocket_bloc.dart';
import 'package:las_customer/presentation/page/exchangePoint.dart';
import 'package:las_customer/presentation/page/order.dart';
import 'package:las_customer/presentation/page/sellTrash.dart';
import 'package:las_customer/presentation/widget/home/articleCard.dart';
import 'package:las_customer/presentation/widget/home/carousel.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
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
                    Text('1000 Poin',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor)),
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
              //container gray with full width
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ComplicatedImageDemo(),
              ),
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
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
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
                            'TUKAR POIN',
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
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ArticleCard(),
                    ArticleCard(),
                    ArticleCard(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
