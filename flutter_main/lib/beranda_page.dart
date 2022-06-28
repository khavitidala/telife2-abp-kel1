import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'food_rec.dart';
import 'medical_record.dart';
import 'widgets/discover_card.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key,}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {

  void onBackIconTapped() {
    Get.back();
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

          ],
        ),
      ),
    );
  }


  void onRenewTapped() {
  }

  void onFoodRecTapped() {
    Get.to(()=> FoodRecPage(), transition: Transition.rightToLeft);
  }

  void onMedicalRecTapped() {
    Get.to(()=> MedicalRecPage(), transition: Transition.rightToLeft);
  }

  void onSearchIconTapped() {
  }
}
