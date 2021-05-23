import 'dart:async';
import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pebbl_design/shared.dart';

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

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
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
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(latitude, longitude),
                                    zoom: 20,
                                  ),
                                  markers: Set<Marker>.of(
                                    <Marker>[
                                      Marker(
                                          draggable: true,
                                          markerId: MarkerId("Marker"),
                                          position: LatLng(latitude, longitude),
                                          icon: BitmapDescriptor.defaultMarker,
                                          onDragEnd: ((newPosition) {
                                            print("LOCATION: ${newPosition.latitude}, ${newPosition.longitude}");
                                            setState(() {
                                              latitude = newPosition.latitude;
                                              longitude = newPosition.longitude;
                                            });
                                          }))
                                    ],
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    TextButton(
                      onPressed: () {
                        /*if (_formKey.currentState!.validate())
                          Navigator.of(context).push(PageTransition(
                              child: Address(),
                              type: PageTransitionType.rightToLeft));*/
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
