import 'package:eabsensi_firebase/ui/guru-login.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _bg = Color(0xff1d3557);
  Color _sec = Color(0xff457b9d);
  Color _tr = Color(0xfff1faee);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: screen.height * 0.2,
            child: Center(
              child: Text(
                "E-Absensi",
                textAlign: TextAlign.center,
                style: GoogleFonts.redressed(fontSize: 30, color: _tr),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: screen.width,
              decoration: BoxDecoration(
                  color: _tr,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              child: LoginGuru(),
                              type: PageTransitionType.rightToLeft,
                            ));
                      },
                      child: _buttonBanner("Guru", Icons.person_pin)),
                  _buttonBanner("Siswa", Icons.people_alt),
                  Center(
                    child: Text(
                      "e-absensi v.0.1 ",
                      style: TextStyle(color: _sec),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonBanner(String text, icon) {
    Size screen = MediaQuery.of(context).size;

    return Container(
      height: screen.height * 0.2,
      width: screen.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_sec, _bg])),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 25,
            ),
            Icon(
              icon,
              color: _tr,
              size: 65,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 20, color: _tr, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
