import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pebbl_design/screens/Home/home.dart';
import 'package:pebbl_design/shared/shared.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  Completer<GoogleMapController> _controller = Completer();

  String address = "";
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Future<Position> get position =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  _getCurrentLocation() async {
    Position pos = await position;
    setState(() {
      latitude = pos.latitude;
      longitude = pos.longitude;
      address = "$latitude, $longitude";
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Patient ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.1),
                          children: [
                            TextSpan(
                                text: "Register.",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.1))
                          ]),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.05,
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.red, width: 3),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.055),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone Verification",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.08),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                  textInputAction: TextInputAction.next,
                                  initialValue: address,
                                  validator: (val) => val!.isEmpty
                                      ? 'Enter a valid address'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => address = val.trim());
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Street Address')),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.black87),
                                ),
                                child: FutureBuilder(
                                    future: position,
                                    builder: (context,
                                        AsyncSnapshot<Position> snapshot) {
                                      return snapshot.data != null
                                          ? GoogleMap(
                                              mapType: MapType.normal,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                    snapshot.data!.latitude,
                                                    snapshot.data!.longitude),
                                                zoom: 18.5,
                                              ),
                                              markers: Set<Marker>.of(
                                                <Marker>[
                                                  Marker(
                                                      draggable: true,
                                                      markerId:
                                                          MarkerId("Marker"),
                                                      position: LatLng(
                                                          latitude, longitude),
                                                      icon: BitmapDescriptor
                                                          .defaultMarker,
                                                      onDragEnd:
                                                          ((newPosition) {
                                                        print(
                                                            "LOCATION: ${newPosition.latitude}, ${newPosition.longitude}");
                                                        setState(() {
                                                          latitude = newPosition
                                                              .latitude;
                                                          longitude =
                                                              newPosition
                                                                  .longitude;
                                                        });
                                                      }))
                                                ],
                                              ),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                _controller
                                                    .complete(controller);
                                              },
                                            )
                                          : Container(
                                              child: Center(
                                                child: Text(
                                                  "Getting your location...",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05),
                                                ),
                                              ),
                                            );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                          Navigator.of(context).pushAndRemoveUntil(
                              PageTransition(
                                  child: Home(),
                                  type: PageTransitionType.rightToLeft),
                              (route) => false);
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: 3,
                      position: 2,
                      decorator: DotsDecorator(
                        activeColor: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
