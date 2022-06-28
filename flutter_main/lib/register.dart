// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterApp extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<RegisterApp> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

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
                  child: Text("Registration",
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
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
          text: 'Submit',
          onClicked: () {
            final isValid = formKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState!.save();

              final message =
                  'Username: $username\nPassword: $password\nEmail: $email';
              final snackBar = SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(fontSize: 20),
                ),
                backgroundColor: Colors.green,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
      );
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
