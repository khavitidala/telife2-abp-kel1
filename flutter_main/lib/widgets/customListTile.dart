import 'package:flutter/material.dart';
import 'package:flutter_main/models/news.dart';
import 'package:flutter_main/widgets/articlesPages.dart';

Widget customListTile(News article, BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArticlePage(article: article)));
    },
    child : Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: const Color(0xff4E81EB),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
            leading: Image.network(
              //menampilkan data gambar
              article.urlToImage,
              fit: BoxFit.cover,
              width: 100,
            ),
            title: Text(
              //menampilkan data judul
              article.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Text(article.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Text(article.publishedAt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
        ),
      ),
    ),
  );
}