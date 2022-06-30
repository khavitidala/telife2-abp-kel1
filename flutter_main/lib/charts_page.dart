import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class ChartsPage extends StatelessWidget {
  const ChartsPage({Key? key}) : super(key: key);

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
                    child: Text("Maps",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Telkom University",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),

                //Content
                SizedBox(
                  height: 488,
                  width: 20,
                  child: MapSample(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};
  final LatLng _currentPosition = LatLng(-6.975575564736307, 107.63055772782457);

  void initState(){
    _markers.add(
        Marker(
          markerId: MarkerId("-6.975575564736307, 107.63055772782457"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarker,
        )
    );
  }

  // Set<Polygon> myPolygon() {
  //   List<LatLng> polygonCoords = [];
  //   polygonCoords.add(LatLng(-6.975581462489882, 107.6307637079522));
  //   polygonCoords.add(LatLng(-6.975575564736307, 107.63055772782457));
  //   polygonCoords.add(LatLng(-6.97600216871913, 107.63055376666827));
  //   polygonCoords.add(LatLng(-6.9760041346352075, 107.6307597467959));
  //
  //   Set<Polygon> polygonSet = new Set();
  //   polygonSet.add(Polygon(
  //       polygonId: PolygonId('test'),
  //       points: polygonCoords,
  //       strokeColor: Colors.red));
  //
  //   return polygonSet;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 14,
        ),
        markers: _markers,
        // polygons: myPolygon(),
      ),
    );
  }
}
