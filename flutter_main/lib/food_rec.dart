import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_main/constant.dart';
import 'package:flutter_main/widgets/dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'models/food.dart';
import 'widgets/svg_asset.dart';
import 'package:http/http.dart' as http;

class FoodRecPage extends StatefulWidget {
  const FoodRecPage({Key? key}) : super(key: key);

  @override
  _FoodRecPageState createState() => _FoodRecPageState();
}

class _FoodRecPageState extends State<FoodRecPage> {
  double _currentSliderValueC = 0;
  double _currentSliderValueE = 71;
  double _currentSliderValueP = 0;
  double _currentSliderValueFa = 0;
  double _currentSliderValueFi = 0;
  double _currentSliderValueCh = 0;
  List<Food> listFood = [];

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
                      child: Text("Food Recommendation",
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
                    "Slide left or right to change the value.",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),

                //content food recommendation
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //slider energy
                          Text("Energy : " + _currentSliderValueE.round().toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Slider(
                            value: _currentSliderValueE,
                            max: 477,
                            min: 71,
                            label: _currentSliderValueE.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueE = value;
                              });
                            },
                          ),

                          //slider carbs
                          Text("Carbohydrate : " + _currentSliderValueC.round().toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Slider(
                            value: _currentSliderValueC,
                            max: 82,
                            min: 0,
                            label: _currentSliderValueC.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueC = value;
                              });
                            },
                          ),

                          //slider protein
                          Text("Protein : " + _currentSliderValueP.round().toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Slider(
                            value: _currentSliderValueP,
                            max: 36,
                            min: 0,
                            label: _currentSliderValueP.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueP = value;
                              });
                            },
                          ),

                          //slider fat
                          Text("Fat : " + _currentSliderValueFa.round().toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Slider(
                            value: _currentSliderValueFa,
                            max: 27,
                            min: 0,
                            label: _currentSliderValueFa.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueFa = value;
                              });
                            },
                          ),

                          //slider fiber
                          Text("Fiber : " + _currentSliderValueFi.round().toString(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Slider(
                            value: _currentSliderValueFi,
                            max: 18,
                            min: 0,
                            label: _currentSliderValueFi.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueFi = value;
                              });
                            },
                          ),

                          //slider cholesterol
                          Text("Cholesterol : " + _currentSliderValueCh.toStringAsFixed(2),
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Slider(
                            value: _currentSliderValueCh,
                            max: 0.7,
                            min: 0,
                            label: _currentSliderValueCh.toStringAsFixed(2),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueCh = value;
                              });
                            },
                          ),

                          //button
                          Center(
                            child: ElevatedButton(
                              child: const Text('Show'),
                              onPressed: () {
                                setState(() {
                                  recommender(
                                    _currentSliderValueE,
                                    _currentSliderValueC,
                                    _currentSliderValueP,
                                    _currentSliderValueFa,
                                    _currentSliderValueFi,
                                    _currentSliderValueCh
                                  );
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                )

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

  recommender(energy, carbo, protein, fat, fiber, cholestrol) async {
    final GlobalKey<State> _keyLoader = GlobalKey<State>();
    Dialogs.loading(context, _keyLoader, "Loading ...");
    
    try {
      final response = await http.post(
          Uri.parse(APIURL+"api/food/"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
              "energy": energy,
              "carbo": carbo,
              "protein": protein,
              "fat" : fat,
              "fiber": fiber,
              "cholestrol": cholestrol
          }));

      final output = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
        for (var i = 0; i < output["data"].length; i++) {
            listFood.add(Food.fromJson(output["data"][i]));
        }
        modalFood(listFood);
      } else {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            output['message'],
            style: const TextStyle(fontSize: 16),
          )),
        );
      }
    } catch (e) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
    }
  }

  modalFood(List<Food> food) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Results:',
                style: TextStyle(fontSize: 20),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(food[0].picUrl),
                      title: Text(food[0].name),
                      subtitle: Text("Total calories: "+food[0].calories.toString()),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(food[1].picUrl),
                      title: Text(food[1].name),
                      subtitle: Text("Total calories: "+food[1].calories.toString()),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(food[2].picUrl),
                      title: Text(food[2].name),
                      subtitle: Text("Total calories: "+food[2].calories.toString()),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      },
    );
  }

  void onBackIconTapped() {
   Get.back();
  }

}
