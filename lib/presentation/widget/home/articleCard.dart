import 'package:flutter/material.dart';
import 'package:las_customer/presentation/page/article.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ArticleCard extends StatelessWidget {
  String imageUrl;
  String title;
  String excerpt;
  ArticleCard({
    // required Key key,
    required this.imageUrl,
    required this.title,
    required this.excerpt,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ArticlePage(
            imageUrl: imageUrl,
            title: title,
            excerpt: excerpt,
          ),
          withNavBar: false,
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    excerpt,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
