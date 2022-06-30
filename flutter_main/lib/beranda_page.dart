import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_main/constant.dart';
import 'package:flutter_main/home_page.dart';
import 'package:flutter_main/models/news.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'food_rec.dart';
import 'medical_record.dart';
import 'medical_record_pasien.dart';
import 'widgets/discover_card.dart';
import 'package:http/http.dart' as http;
import 'widgets/customListTile.dart';
import 'dart:math';


class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key,}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<News> listNews = [];
  int pagesize = 3;
  int randompage = Random().nextInt(7);
  bool isKonselor = false;

  getListNews() async {
    try {
      final response = await http.get(
          Uri.parse(NEWSAPI+pagesize.toString()+"&page="+randompage.toString()),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        final dataDecode = jsonDecode(response.body);
        setState(() {
          for (var i = 0; i < dataDecode["articles"].length; i++) {
            if (dataDecode['articles'][i]['urlToImage'] is String){
              listNews.add(News.fromJson(dataDecode["articles"][i]));
            }
          }
        });
      }
      randompage = Random().nextInt(7);
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<bool> cekKonselor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("is_konselor")!;
  }

  @override
  void initState() {
    getListNews();
    cekKonselor().then((x) {
      setState(() {
        isKonselor = x;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 18.w,
                top: 36.h,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
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
                physics: BouncingScrollPhysics(),
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
                        color: Color(0xff515979),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w),
                  ),
                  GestureDetector(
                      onTap: onRenewTapped,
                      child: Text("Renew News",
                          style: TextStyle(
                              color: Color(0xff4A80F0),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.w)))
                ],
              ),

            ),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listNews.length,
              itemBuilder: (BuildContext context, int index) {
                return customListTile(listNews[index], context);
              }
            ),
          ],
        ),
      ),
    );
  }

  void onRenewTapped() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomePage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  void onFoodRecTapped() {
    Get.to(()=> FoodRecPage(), transition: Transition.rightToLeft);
  }

  void onMedicalRecTapped() {
    if (isKonselor==true) {
      Get.to(()=> MedicalRecPage(), transition: Transition.rightToLeft);
    } else {
      Get.to(()=> MedicalRecPasienPage(), transition: Transition.rightToLeft);
    }
    
  }

  void onSearchIconTapped() {
  }
}
