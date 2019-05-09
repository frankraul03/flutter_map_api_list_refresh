import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapApp extends StatefulWidget {
  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: <Widget>[
            _googleMap(context),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Text(
            //   "Major Dealers",
            //   style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
            // ),
            // _buildContainer()
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: 110.0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/e5/07/a3.jpg",
                  27.3949,
                  84.1240,
                  "Chitwan"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "http://pashupatinathtemple.org/wp-content/uploads/2017/08/5Pashupatinath_Temple_Sorrounding.jpg",
                  28.3949,
                  84.1240,
                  "Jhapa"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMV_LE6XHKoxQI2OgNDav9wtdBnB8t3Z_5QzwE=w213-h160-k-no",
                  28.3949,
                  85.1240,
                  "Biratnagar"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipOqRBtejwkceI6m39q6yuMgexS7dOWnGCKyaRz9=w240-h160-k-no",
                  28.3949,
                  86.1240,
                  "Illam"),
            )
          ],
        ),
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(28.3949, 84.1240), zoom: 5.8),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {customMarker1, customMarker2, customMarker3, customMarker4},
      ),
    );
  }

  // Widget _boxes(String _image, double lat, double long, String locName) {
  //   return GestureDetector(
  //     onTap: () {
  //       _gotoLocation(lat, long);
  //     },
  //     child: Container(
  //       child: new FittedBox(
  //         child: Material(
  //           color: Colors.white,
  //           elevation: 14.0,
  //           borderRadius: BorderRadius.circular(24.0),
  //           shadowColor: Color(0x802196F3),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Container(
  //                 width: 180,
  //                 height: 200,
  //                 child: ClipRRect(
  //                   borderRadius: new BorderRadius.circular(24.0),
  //                   child: Image(
  //                     fit: BoxFit.fill,
  //                     image: NetworkImage(_image),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _boxes(String _image, double lat, double long, String locName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(locName,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 10.0),
                            Text("ABC Pvt.Ltd.",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue)),
                            Text("Phone:9843401415",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 10.0, tilt: 50.0)));
  }
}

Marker customMarker1 = Marker(
    markerId: MarkerId("Kathmandu,Nepal"),
    position: LatLng(27.3949, 84.1240),
    infoWindow: InfoWindow(title: "Office"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    ));

Marker customMarker2 = Marker(
    markerId: MarkerId("Nepal"),
    position: LatLng(
      28.3949,
      84.1240,
    ),
    infoWindow: InfoWindow(title: "Office"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    ));

Marker customMarker3 = Marker(
    markerId: MarkerId("Nepal"),
    position: LatLng(
      28.3949,
      84.1540,
    ),
    infoWindow: InfoWindow(title: "Office"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    ));

Marker customMarker4 = Marker(
    markerId: MarkerId("Nepal"),
    position: LatLng(
      28.3949,
      84.1440,
    ),
    infoWindow: InfoWindow(title: "Office"),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueBlue,
    ));
