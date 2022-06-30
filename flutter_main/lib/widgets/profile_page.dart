import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                  height: 36.h,
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
                SizedBox(height: 25.h),

                //Content
                const SizedBox(
                  height: 488,
                  width: 20,
                  child: profilePage1(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class profilePage1 extends StatefulWidget {
  const profilePage1({Key? key}) : super(key: key);

  @override
  State<profilePage1> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage1> {

  static const kSpacingUnit = 10;

  final kTitleTextStyle = TextStyle(
      fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
      fontWeight: FontWeight.w600,
      color: Colors.white
  );

  final kCaptionTextStyle = TextStyle(
      fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
      fontWeight: FontWeight.w100,
      color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    return Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/pics/avatar.png'),
                ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            'Ryan Abdurohman',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'Ryan Abdurohman',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
    );

  }
}

