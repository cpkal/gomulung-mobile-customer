import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/presentation/page/login.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Doe'),
                      Text('john.doe@example.com'),
                      Text('Layanan: Rumahan'),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 10,
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
            SizedBox(height: 20),
            //list menu
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {},
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.edit_outlined),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text('Edit Profil'),
                  //     ],
                  //   ),
                  // ),

                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Histori Pesanan'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.help),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Bantuan'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Keluar'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
