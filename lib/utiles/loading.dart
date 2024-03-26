// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

loading(context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
