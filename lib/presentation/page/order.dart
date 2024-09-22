import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/route/route_paths.dart';
import 'package:las_customer/model/repository/authentication_repository.dart';
import 'package:las_customer/presentation/page/map.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class OrderPage extends StatelessWidget {
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
                //pick location
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
                        screen: MapPage(),
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
                        Text('Pilih lokasi'),
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
                            return Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: //colors with gradient
                                    index == 0
                                        ? Colors.red
                                        : index == 1
                                            ? Colors.green
                                            : index == 2
                                                ? Colors.blue
                                                : index == 3
                                                    ? Colors.yellow
                                                    : index == 4
                                                        ? Colors.purple
                                                        : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  '1',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
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
                        SizedBox(
                          height: 20,
                        ),
                        //map container with border

                        //irch text ada 5 Kru LAS terdekat
                        RichText(
                          text: TextSpan(
                            text: 'Ada ', // First part of the sentence
                            style: DefaultTextStyle.of(context)
                                .style, // Default style
                            children: <TextSpan>[
                              TextSpan(
                                text: '5', // Number part
                                style: TextStyle(
                                  fontWeight: FontWeight
                                      .bold, // Bold style for emphasis
                                  color: Colors.red, // Change color to red
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' Kru LAS terdekat', // Rest of the sentence
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Google_maps_screenshot.png/300px-Google_maps_screenshot.png',
                            fit: BoxFit.fill,
                          ),
                        )
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
                      screen: MapPage(),
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
            // Positioned(
            //   bottom: 0,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height * 0.6,
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.surface,
            //       //border radius top right and left top
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(20),
            //         topRight: Radius.circular(20),
            //       ),
            //       //border grey
            //       border: Border.all(
            //         color: Colors.grey,
            //       ),
            //     ),
            //     child: Container(
            //       padding: EdgeInsets.all(30),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "PILIH METODE PEMBAYARAN",
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .headlineSmall
            //                 ?.copyWith(fontWeight: FontWeight.bold),
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           //select payment method
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Image.network(
            //                 'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
            //                 width: 100,
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(),
            //                 child: Text('Pilih'),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           //select payment method
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Image.network(
            //                 'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
            //                 width: 100,
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(),
            //                 child: Text('Pilih'),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           //select payment method
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Image.network(
            //                 'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
            //                 width: 100,
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(),
            //                 child: Text('Pilih'),
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           //select payment method
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Image.network(
            //                 'https://antinomi.org/wp-content/uploads/2022/03/logo-gopay-vector.png',
            //                 width: 100,
            //               ),
            //               ElevatedButton(
            //                 onPressed: () {},
            //                 style: ElevatedButton.styleFrom(),
            //                 child: Text('Pilih'),
            //               )
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
