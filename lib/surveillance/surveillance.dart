import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class Surveillancc extends StatefulWidget {
  const Surveillancc({super.key});

  @override
  State<Surveillancc> createState() => _SurveillanccState();
}

class _SurveillanccState extends State<Surveillancc> {
  @override
  Widget build(BuildContext context) {
    bool isRunning = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Surveillance'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Center(
                  child: Mjpeg(isLive: isRunning, stream: '..............')))
        ],
      ),
    );
  }
}
