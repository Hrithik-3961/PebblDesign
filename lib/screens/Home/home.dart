import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pebbl_design/shared/shared.dart';

import '../../app_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar2(
        appBar: AppBar(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            boxShadow: [BoxShadow(color: Colors.red[100]!, spreadRadius: 1.5)]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined), label: "Records"),
              BottomNavigationBarItem(icon: Icon(null), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart_sharp), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bluetooth_outlined), label: "Device")
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: StadiumBorder(side: BorderSide(color: Colors.red, width: 2)),
        onPressed: () {},
        child: Icon(
          AppIcons.heartbeat,
          color: Colors.red,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.red[50],
                  boxShadow: [
                    BoxShadow(color: Colors.grey[300]!, spreadRadius: 2)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.12,
                        backgroundColor: Colors.white,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey Arjun!",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08),
                      ),
                      Row(
                        children: [
                          Text(
                            "PID: 12345xxxxx",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.copy,
                              size: 12,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[300]!, spreadRadius: 1)
                  ]),
              child: TabBarView(controller: _controller, children: [
                Vitals(vital: "Pulse"),
                Vitals(vital: "SpO2%"),
                Vitals(vital: "Temperature")
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class Vitals extends StatefulWidget {
  final String vital;

  Vitals({required this.vital});

  @override
  _VitalsState createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> {
  String dropDownValue = "1";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.red,
                onPressed: () {},
                child: Text(
                  widget.vital,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.025),
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    value: dropDownValue,
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.red,
                    onChanged: (val) {
                      setState(() {
                        dropDownValue = val.toString();
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Text(
                          "Last Week",
                        ),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Text(
                          "Last Month",
                        ),
                      ),
                      DropdownMenuItem(
                        value: "3",
                        child: Text(
                          "Last Year",
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            color: Colors.white,
          ),
          Expanded(child: Container()),
          DotsIndicator(
            dotsCount: 3,
            position: widget.vital == "Pulse"
                ? 0
                : widget.vital == "SpO2%"
                    ? 1
                    : 2,
            decorator: DotsDecorator(
                activeColor: Colors.redAccent, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
