import 'package:flutter/material.dart';
import 'package:flutter_main/models/news.dart';
import 'package:url_launcher/link.dart';

class ArticlePage extends StatelessWidget {
  final News article;

  ArticlePage({required this.article});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: const Color(0xff441DFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null ?
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ) :
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: NetworkImage('https://source.unsplash.com/weekly?coding'), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                article.author,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  article.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                )
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: Link(
                  target: LinkTarget.self,
                  uri: Uri.parse(article.url),
                  builder: (context, followLink) => TextButton(
                    onPressed: followLink,
                    child: const Text(
                      'baca selengkapnya',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                )
            ),
          ],
        ),
      ),
    );
  }
}
