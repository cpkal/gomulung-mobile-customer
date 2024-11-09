import 'package:flutter/material.dart';
import 'package:las_customer/presentation/widget/home/articleCard.dart';

class ListArticleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ArticleCard(),
          ArticleCard(),
          ArticleCard(),
        ],
      ),
    );
  }
}
