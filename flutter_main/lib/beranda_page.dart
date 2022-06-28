import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'food_rec.dart';
import 'medical_record.dart';
import 'widgets/discover_card.dart';
import 'package:http/http.dart' as http;

class Source{
  final String id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(id: json['id'], name: json['name']);
  }
}

class News {
  // final int userId;
  // final int id;
  // final String title;
  // final bool completed;
  final Source source;
  final String title;
  final String description;
  final String author;
  final String publishedAt;
  final String url;
  final String urlToImage;


  News({required this.source, required this.title, required this.description,
    required this.author, required this.publishedAt, required this.url, required this.urlToImage});

  factory News.fromJson(Map<String, dynamic> json){
    return News(
      source: Source.fromJson(json['source']),
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
    );
  }
}

class ApiService {


  Future<List<News>> getNews() async {
    final res = await get(
        Uri.parse("http://newsapi.org/v2/top-headlines?country=id&category=health&apiKey=eb73e8e6bf3f4375883cbc0da9954bb3&pageSize=3"));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      List<News> news = body.map((dynamic item) => News.fromJson(item)).toList();

      return news;
    } else {
      throw ("Can't get the News");
    }
  }
}

// main
class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key,}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 18.w,
                top: 36.h,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Telife",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold)),
                )
            ),

            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 176.w,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 28.w),
                  DiscoverCard(
                    tag: "foodRec",
                    onTap: onFoodRecTapped,
                    title: "Food Recommendation",
                    subtitle: "dapatkan rekomendasi makanan dengan kandungan yang diinginkan",
                  ),
                  SizedBox(width: 20.w),
                  DiscoverCard(
                    onTap: onMedicalRecTapped,
                    title: "Get your Medical Record",
                    subtitle: "mengakses catatan kesehatan pasien",
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 24.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent",
                    style: TextStyle(
                        color: const Color(0xff515979),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w),
                  ),
                  GestureDetector(
                      onTap: onRenewTapped,
                      child: Text("Renew News",
                          style: TextStyle(
                              color: const Color(0xff4A80F0),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.w)))
                ],
              ),

            ),
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.only(
                  left: 28.w,
                  right: 24.w
              ),
              child: FutureBuilder(
                future: client.getNews(),
                builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){

                  if (snapshot.hasData){
                    List<News> news = snapshot.data ?? <News>[];
                    return ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) => ListTile(title: Text(news[index].title),),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  void onRenewTapped() {
  }

  void onFoodRecTapped() {
    Get.to(()=> const FoodRecPage(), transition: Transition.rightToLeft);
  }

  void onMedicalRecTapped() {
    Get.to(()=> const MedicalRecPage(), transition: Transition.rightToLeft);
  }

  void onSearchIconTapped() {
  }
}

class NewsView extends StatelessWidget{
  const NewsView({Key? key, required this.news}) : super(key: key);

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index){
        return Card(
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Todo(data: news[index])))
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          "${news[index].source}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "${news[index].title}",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ),
              )
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class Todo extends StatelessWidget {
  Todo({Key? key, required this.data}) : super(key: key);
  News data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          "Source: ${data.source}\n\n"
              "title: ${data.title}\n\n"
              "description: ${data.description}\n\n"
        )
      ),
    );
  }
}

