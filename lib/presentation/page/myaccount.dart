import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:las_customer/core/util/secure_storage.dart';
import 'package:las_customer/presentation/page/login.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({Key? key}) : super(key: key);

  final _secureStorage = SecureStorage();

  Future<void> _logout(BuildContext context) async {
    // await context.read<AuthBloc>().add(AuthLogoutRequested());
    await _secureStorage.deleteSecureData(key: 'token');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
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
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text('Akun saya'),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text('Ganti password'),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text('Histori pesanan'),
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
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text('Keluar'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
