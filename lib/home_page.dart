import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pebbl_design/shared.dart';
import 'package:pebbl_design/personal_details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBar: AppBar()),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                      text: "Let's get you ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.07),
                      children: [
                    TextSpan(
                        text: "started!",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: MediaQuery.of(context).size.width * 0.07))
                  ])),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                "I am a",
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PersonalDetails()));
                  },
                  child: Text(
                    "Patient",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07),
                  ),
                  color: Colors.red),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width * 0.7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.red)),
                onPressed: () {},
                child: Text(
                  "Doctor",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.07),
                ),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
