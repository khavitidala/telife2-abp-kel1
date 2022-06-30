import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_main/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'widgets/svg_asset.dart';
import 'datamedicalrecords/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_main/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalRecPasienPage extends StatefulWidget {
  const MedicalRecPasienPage({Key? key}) : super(key: key);

  @override
  _MedicalRecPasienPageState createState() => _MedicalRecPasienPageState();
}

class _MedicalRecPasienPageState extends State<MedicalRecPasienPage> {

  List<MR> mrs = [];
  bool loading = false;
  String nim = "";

  Future<String> ceckLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("nim")!;
  }

  void getMrs(String nim) async {
    try {
      final response = await http.get(
          Uri.parse(APIURL+"api/medical/"+nim+"/"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        final dataDecode = jsonDecode(response.body);
        setState(() {
          // if(mrs.isEmpty) {
            for (var i = 0; i < dataDecode["data"].length; i++) {
              debugPrint(dataDecode["data"][i].toString());
              mrs.add(MR.fromJson(dataDecode["data"][i]));
            }
          // }
          loading = false;
        });
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    ceckLogin().then((x) {
      setState(() {
        nim = x;
        getMrs(nim);
        debugPrint(x);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Material(
                    color: Colors.transparent,
                    child: Text("Medical Record",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Below is your medical record in telkomedika clinic",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),

                //Content

                Container(
                  padding: EdgeInsets.only(left: 28.w, right: 28.w),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mrs.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      MR mr = mrs[index];
                      return Card(
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          title: Text( mr.diagnosa, //diisi sama diagnosa
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.w,
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text(mr.title, //bebas mau pake atau nggak
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(mr: mrs[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            Align(alignment: Alignment.topCenter,
                child: Container(
                  color:  Color(0xff121421),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 22.w,
                        right: 22.w,
                        top: 20.h,
                        bottom: 10.h
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onBackIconTapped,
                            child: Container(
                              height: 35.w,
                              width: 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Center(
                                child: SvgAsset(
                                  assetName: AssetName.back,
                                  height: 20.w,
                                  width: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  void onBackIconTapped() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
        (route) => false,
      );
  }

  @override
  dispose() {
    super.dispose();
  }

}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.mr}) : super(key: key);
  final MR mr;

  void onBackIconTapped() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(mr.diagnosa, //nanti diisi diagnosa
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Below is your medical record in telkomedika clinic",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),

                //Content
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NIM : '+ mr.pasien,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Diagnosa : '+ mr.diagnosa,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Treatment : '+ mr.treatment,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),

            Align(alignment: Alignment.topCenter,
                child: Container(
                  color:  Color(0xff121421),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 22.w,
                        right: 22.w,
                        top: 20.h,
                        bottom: 10.h
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onBackIconTapped,
                            child: Container(
                              height: 35.w,
                              width: 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Center(
                                child: SvgAsset(
                                  assetName: AssetName.back,
                                  height: 20.w,
                                  width: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ],
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