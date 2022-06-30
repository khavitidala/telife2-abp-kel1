// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_main/constant.dart';
import 'package:flutter_main/home_page.dart';
import 'package:flutter_main/models/user.dart';
import 'package:flutter_main/widgets/dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String identityNumber = '';
  String username = '';
  String email = '';
  String password = '';

  getUser() async {
    try {
      final response = await http.get(
          Uri.parse(APIURL+"api/akun/"+identityNumber+"/"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        final dataDecode = jsonDecode(response.body);
        setState(() {
          User user = User.fromJson(dataDecode);
          name = user.nama;
          username = user.username;
          email = user.email;
          password = user.password;
          debugPrint(name);
        });
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<String> cekNIM() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("nim")!;
  }

  @override
  void initState() {
    cekNIM().then((nim) {
      setState(() {
        identityNumber = nim;
      });
    });
    print(identityNumber);
    getUser();
    super.initState();
  }

  void onBackIconTapped() {
    Get.back();
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (BuildContext context) => const HomePage(),
    //     ),
    //     (route) => false,
    //   );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 66.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: Material(
                  color: Colors.transparent,
                  child: Text("Profile",
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
                  "Please fill all fields",
                  style: TextStyle(
                      color: const Color(0xffffffff).withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.w),
                ),
              ),
              SizedBox(height: 25.h),
              Form(
                key: formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    buildName(),
                    SizedBox(height: 16.h),
                    buildNim(),
                    SizedBox(height: 16.h),
                    buildUsername(),
                    SizedBox(height: 16.h),
                    buildEmail(),
                    SizedBox(height: 32.h),
                    buildPassword(),
                    SizedBox(height: 32.h),
                    buildSubmit(),
                  ],
                ),
              ),
            ])
      ));

  Widget buildName() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Name',
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value!.length < 2) {
            return 'Enter at least 2 characters';
          } else {
            return null;
          }
        },
        maxLength: 255,
        onSaved: (value) => setState(() => name = value!),
        initialValue: name,
      );

  Widget buildNim() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Identity Numbers',
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value!.length < 2) {
            return 'Enter at least 2 characters';
          } else {
            return null;
          }
        },
        maxLength: 255,
        onSaved: (value) => setState(() => identityNumber = value!),
        readOnly: true,
        initialValue: identityNumber,
      );

  Widget buildUsername() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Username',
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => username = value!),
        initialValue: username,
      );

  Widget buildEmail() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Email',
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
        ),
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => email = value!),
        initialValue: email,
      );

  Widget buildPassword() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
        ),
        validator: (value) {
          if (value!.length < 7) {
            return 'Password must be at least 7 characters long';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value!),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        initialValue: password,
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Edit',
          onClicked: () {
            setState(() {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                formKey.currentState!.save();
                doEdit(name, identityNumber, username, email, password);
                // final message =
                //     'Username: $username\nPassword: $password\nEmail:';
                // final snackBar = SnackBar(
                //   content: Text(
                //     message,
                //     style: const TextStyle(fontSize: 20),
                //   ),
                //   backgroundColor: Colors.green,
                // );
                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
        ),
      );
  
  doEdit(name, identityNumber, username, email, password) async {
    final GlobalKey<State> _keyLoader = GlobalKey<State>();
    Dialogs.loading(context, _keyLoader, "Loading ...");

    try {
      final response = await http.put(
          Uri.parse(APIURL+"api/akun/"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "nama": name,
            "nim": identityNumber,
            "username": username,
            "email": email,
            "password": password,
          }));

      final output = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
            "Update Succesfuly",
            style: TextStyle(fontSize: 16),
          )),
        );
        //debugPrint(output['message']);
      } else {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
        //debugPrint(output['message']);
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

  @override
  dispose() {
    super.dispose();
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
        shape: const StadiumBorder(),
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textColor: const Color(0xff121421),
        onPressed: onClicked,
      );
}

