import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'widgets/svg_asset.dart';
import 'datamedicalrecords/services.dart';
import 'datamedicalrecords/user.dart';

class MedicalRecPage extends StatefulWidget {
  const MedicalRecPage({Key? key}) : super(key: key);

  @override
  _MedicalRecPageState createState() => _MedicalRecPageState();
}

class _MedicalRecPageState extends State<MedicalRecPage> {

  List<User> users = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    Services.getUsers().then((list) {
      setState(() {
        users = list;
        loading = false;
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
                  padding: EdgeInsets.only(left: 28.w),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      User user = users[index];
                      return Card(
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          title: Text(user.title, //diisi sama diagnosa
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.w,
                                fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text(user.title, //bebas mau pake atau nggak
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(user: users[index]),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormMedical(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void onBackIconTapped() {
    Get.back();
  }

}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.user}) : super(key: key);
  final User user;

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
                    child: Text(user.title, //nanti diisi diagnosa
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
                      Text('User ID : '+ user.userId.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('NIM : '+ user.id.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Diagnosa : '+ user.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold),),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Treatment : '+ user.title,
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

class FormMedical extends StatefulWidget {
  const FormMedical({Key? key}) : super(key: key);
  @override
  _FormMedical createState() => _FormMedical();
}

class _FormMedical extends State<FormMedical> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  void onBackIconTapped() {
    Get.back();
  }

  String nim = "";
  String diagnosa = "";
  String treatment = "";

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
                    child: Text("Masukkan Data",
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
                    "Pastikan data yang diisi sudah sesuai",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),

                //Content

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: 'NIM',
                                    labelStyle: TextStyle(
                                        color: Colors.white
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide:
                                      BorderSide(color: Colors.grey, width: 0.0),
                                    ),
                                    border: OutlineInputBorder()),
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    nim = value;
                                    // firstNameList.add(firstName);
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    nim = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length < 3) {
                                    return 'First Name must contain at least 3 characters';
                                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                    return 'First Name cannot contain special characters';
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    labelText: 'Diagnosa',
                                    labelStyle: TextStyle(
                                        color: Colors.white
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide:
                                      BorderSide(color: Colors.grey, width: 0.0),
                                    ),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length < 3) {
                                    return 'Last Name must contain at least 3 characters';
                                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                    return 'Last Name cannot contain special characters';
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    diagnosa = value;
                                    // lastNameList.add(lastName);
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    diagnosa = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                maxLines: 5,
                                decoration: const InputDecoration(
                                    labelText: 'Treatment',
                                    labelStyle: TextStyle(
                                        color: Colors.white
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                                    ),
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.length < 3) {
                                    return 'Last Name must contain at least 3 characters';
                                  } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                    return 'Last Name cannot contain special characters';
                                  }
                                },
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    treatment = value;
                                    // lastNameList.add(lastName);
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    treatment= value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(60)),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text("Submit"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
}