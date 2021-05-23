import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pebbl_design/address.dart';
import 'package:pebbl_design/shared.dart';

class MobileVerification extends StatefulWidget {
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  final _formKey = GlobalKey<FormState>();

  String phoneNo = "";
  String otp = "";

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
                                validator: (val) => val!.isEmpty
                                    ? 'Enter your phone number'
                                    : val.length != 10
                                        ? "Enter a valid number"
                                        : null,
                                onChanged: (val) {
                                  setState(() => phoneNo = val.trim());
                                },
                                decoration: textInputDecoration.copyWith(
                                  labelText: 'Phone Number',
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                  textInputAction: TextInputAction.next,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter the otp' : null,
                                  onChanged: (val) {
                                    setState(() => otp = val.trim());
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Enter OTP')),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                          Navigator.of(context).push(PageTransition(
                              child: Address(),
                              type: PageTransitionType.rightToLeft));
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
                      position: 1,
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
