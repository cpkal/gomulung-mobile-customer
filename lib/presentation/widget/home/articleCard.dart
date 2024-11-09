import 'package:flutter/material.dart';
import 'package:las_customer/presentation/page/article.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ArticleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ArticlePage(),
          withNavBar: false,
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cara memilah sampah dengan benar',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Memilah sampah dengan benar akan memudahkan proses daur ulang',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    maxLines: 2,
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
