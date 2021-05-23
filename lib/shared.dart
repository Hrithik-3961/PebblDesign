import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  MyAppBar({required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      centerTitle: true,
      title: Image.asset(
        "assets/images/logo.jpeg",
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.025,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.grey),
  focusColor: Colors.black,
  fillColor: Colors.white,
  filled: true,
  enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  disabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
);
