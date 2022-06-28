// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter_main/constant.dart';
import 'package:flutter_main/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';
import 'models/user.dart';

class LoginApp extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<LoginApp> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: mainView(),
      ));

  Widget mainView() =>
      ListView(physics: const BouncingScrollPhysics(), children: [
        SizedBox(
          height: 66.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 28.w),
          child: Material(
            color: Colors.transparent,
            child: Text("Login",
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
              buildUsername(),
              SizedBox(height: 16.h),
              buildPassword(),
              SizedBox(height: 32.h),
              buildSubmit(),
            ],
          ),
        ),
      ]);

  Widget buildUsername() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Username',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
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
      );

  Widget buildPassword() => TextFormField(
        style: const TextStyle(color: Color(0xFFbdc6cf)),
        decoration: const InputDecoration(
          labelText: 'Password',
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          errorStyle: TextStyle(color: Colors.red),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Password must be at least 4 characters long';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value!),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            setState(() {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                formKey.currentState!.save();
                doLogin(username, password);
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

  doLogin(username, password) async {
    final GlobalKey<State> _keyLoader = GlobalKey<State>();
    Dialogs.loading(context, _keyLoader, "Loading ...");

    try {
      final response = await http.post(
          Uri.parse(APIURL+"api/login/"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "username": username,
            "password": password,
          }));

      final output = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: false).pop();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text(
        //     output['message'],
        //     style: const TextStyle(fontSize: 16),
        //   )),
        // );

        saveSession(User.fromJson(jsonDecode(response.body)));
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

  saveSession(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("username", user.username);
    await pref.setBool("is_login", true);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
      (route) => false,
    );
  }

  void ceckLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    ceckLogin();
    super.initState();
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
  Widget build(BuildContext context) => ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Color(0xff121421)),
        ),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        onPressed: onClicked,
      );
}
