import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pebbl_design/screens/Register/mobile_verification.dart';
import 'package:pebbl_design/shared/shared.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

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
                                "Personal Details",
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
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter a name' : null,
                                  onChanged: (val) {
                                    setState(() => name = val.trim());
                                  },
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Name',
                                  )),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                  textInputAction: TextInputAction.next,
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() => email = val.trim());
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: 'Email')),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                validator: (val) => val!.length < 6
                                    ? 'Enter a password with at least 6 characters'
                                    : password != confirmPassword
                                        ? "Entered Passwords are different!"
                                        : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val.trim());
                                },
                                decoration: textInputDecoration.copyWith(
                                  labelText: 'Password',
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              TextFormField(
                                validator: (val) => val!.length < 6
                                    ? 'Enter a password with at least 6 characters'
                                    : password != confirmPassword
                                        ? "Entered Passwords are different!"
                                        : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => confirmPassword = val.trim());
                                },
                                decoration: textInputDecoration.copyWith(
                                  labelText: 'Confirm Password',
                                ),
                              ),
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
                              child: MobileVerification(),
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
                      decorator: DotsDecorator(
                        activeColor: Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01,)
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
