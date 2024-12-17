import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String excerpt;

  ArticlePage({
    required this.imageUrl,
    required this.title,
    required this.excerpt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            //writer and date published
            Row(
              children: <Widget>[
                Text("John Doe |"),
                Text(" 12 Agustus 2024"),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 8.0),
            //thumbnail image
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 16.0),
            Text(
                "Ad quis velit cillum voluptate veniam non mollit ad nulla est proident aute ullamco irure. Ad reprehenderit quis ea adipisicing cupidatat et consequat. Consectetur fugiat aliqua fugiat non irure ex laborum et Lorem dolor quis. Mollit pariatur veniam aute fugiat deserunt veniam esse consequat veniam. Nisi ullamco Lorem eu ipsum veniam exercitation ad culpa mollit nulla veniam voluptate proident. Dolor consectetur exercitation consectetur in nulla culpa culpa ad sunt amet sit."),
            Text(
                "Ad quis velit cillum voluptate veniam non mollit ad nulla est proident aute ullamco irure. Ad reprehenderit quis ea adipisicing cupidatat et consequat. Consectetur fugiat aliqua fugiat non irure ex laborum et Lorem dolor quis. Mollit pariatur veniam aute fugiat deserunt veniam esse consequat veniam. Nisi ullamco Lorem eu ipsum veniam exercitation ad culpa mollit nulla veniam voluptate proident. Dolor consectetur exercitation consectetur in nulla culpa culpa ad sunt amet sit."),
            Text(
                "Ad quis velit cillum voluptate veniam non mollit ad nulla est proident aute ullamco irure. Ad reprehenderit quis ea adipisicing cupidatat et consequat. Consectetur fugiat aliqua fugiat non irure ex laborum et Lorem dolor quis. Mollit pariatur veniam aute fugiat deserunt veniam esse consequat veniam. Nisi ullamco Lorem eu ipsum veniam exercitation ad culpa mollit nulla veniam voluptate proident. Dolor consectetur exercitation consectetur in nulla culpa culpa ad sunt amet sit."),
          ],
        ),
      ),
    );
  }
}
