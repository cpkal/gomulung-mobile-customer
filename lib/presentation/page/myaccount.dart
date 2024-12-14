import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/util/secure_storage.dart';
import 'package:las_customer/data/datasource/remote/api_service.dart';
import 'package:las_customer/presentation/page/change_password.dart';
import 'package:las_customer/presentation/page/login.dart';
import 'package:las_customer/presentation/page/order_history.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _secureStorage = SecureStorage();
  String? name;
  String? email;

  Future<void> _logout(BuildContext context) async {
    // await context.read<AuthBloc>().add(AuthLogoutRequested());
    await _secureStorage.deleteSecureData(key: 'token');

    //exit app
    SystemNavigator.pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    // http call to get user data
    final res = await ApiService.fetchData('/users');
    final decoded = jsonDecode(res.body);

    setState(() {
      name = decoded['name'];
      email = decoded['email'];
    });
  }

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
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: ClipOval(
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/1144/1144760.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? 'John Doe',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email ?? 'johndoe@mail.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            //list menu
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //       padding: EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.grey),
                  //         borderRadius: BorderRadius.circular(100),
                  //       ),
                  //       child: Center(
                  //         child: Text('Akun saya'),
                  //       )),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: ChangePasswordPage());
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            'Ganti password',
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: OrderHistoryPage());
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            'Histori Pesanan',
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 5,
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => _logout(context),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      'Keluar',
                      style: TextStyle(color: Colors.red),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
