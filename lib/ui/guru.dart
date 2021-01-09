import 'package:flutter/material.dart';

class GuruPage extends StatefulWidget {
  @override
  _GuruPageState createState() => _GuruPageState();
}

class _GuruPageState extends State<GuruPage> {
  Color _bg = Color(0xff1d3557);
  Color _sec = Color(0xff457b9d);
  Color _tr = Color(0xfff1faee);
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screen.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [_bg, _sec],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
        ],
      ),
    );
  }
}
