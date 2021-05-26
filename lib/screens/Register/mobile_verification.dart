import 'package:base32/base32.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:otp/otp.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pebbl_design/screens/Register/address.dart';
import 'package:pebbl_design/shared/shared.dart';

class MobileVerification extends StatefulWidget {
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  final _formKey = GlobalKey<FormState>();

  String phoneNo = "";
  String otp = "";
  String generatedOtp = "";
  String error = "";
  bool otpEnabled = true;
  bool sendOtpEnabled = true;
  List<String> recipients = [];

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
                              TextButton(
                                  onPressed: () async {
                                    //AuthService().verifyNum(phoneNo);
                                    if (_formKey.currentState!.validate()) {
                                      generatedOtp = OTP.generateTOTPCodeString(
                                          base32.encodeString(phoneNo),
                                          DateTime.now().millisecondsSinceEpoch,
                                          interval: 2);
                                      recipients.clear();
                                      recipients.add(phoneNo);
                                      await sendSMS(
                                              message:
                                                  "Your OTP to register in the Pebbl app is: $generatedOtp. It'll expire in 2 minutes so complete the process soon",
                                              recipients: recipients)
                                          .catchError((error) {
                                        print("ERROR: $error");
                                      });
                                      setState(() {
                                        otpEnabled = true;
                                      });
                                    } else
                                      setState(() {
                                        otpEnabled = false;
                                      });
                                  },
                                  child: Text("Send OTP")),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015),
                              TextFormField(
                                enabled: otpEnabled,
                                textInputAction: TextInputAction.next,
                                onChanged: (val) {
                                  setState(() => otp = val.trim());
                                },
                                decoration: textInputDecoration.copyWith(
                                    labelText: 'Enter OTP'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015),
                              Text(
                                error,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.red[800]),
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
                          //if(generatedOtp == otp)
                          Navigator.of(context).push(PageTransition(
                              child: Address(),
                              type: PageTransitionType.rightToLeft));
                        /*else
                            setState(() {
                              error = "Entered otp doesn't match";
                            });*/
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
