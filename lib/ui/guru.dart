import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'package:page_transition/page_transition.dart';

class GuruPage extends StatefulWidget {
  @override
  _GuruPageState createState() => _GuruPageState();
}

class _GuruPageState extends State<GuruPage> {
  Color _bg = Color(0xff1d3557);
  Color _sec = Color(0xff457b9d);
  Color _tr = Color(0xfff1faee);

  TextEditingController _tanggalController = new TextEditingController();
  TextEditingController _kelasController;
  TextEditingController _pelajaran;

  _setDate(value) {
    setState(() {
      _tanggalController.text = DateFormat('yyyy-MM-dd').format(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _tanggalController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              barrierColor: Colors.black45,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => _bottomSheet());
        },
        backgroundColor: _bg,
        child: Center(
          child: Icon(Icons.add_rounded),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: [
            Container(
              height: screen.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [_bg, _sec],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
            Column(
              children: [
                Container(
                  height: screen.height * 0.2,
                  child: Center(
                    child: Text("Daftar Absensi",
                        style: GoogleFonts.redressed(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: _tr)),
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  1,
                                  2,
                                  3,
                                  4,
                                  5,
                                ].map((e) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _absenWidget(e),
                                    );
                                  });
                                }).toList(),
                              ),
                              Center(
                                child: Text(
                                  "e-absensi v.0.1",
                                  style: TextStyle(color: _sec),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _absenWidget(index) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: _sec, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _tr,
          child: Center(child: Text(index.toString())),
        ),
        title: Text(
          "test",
          style: TextStyle(color: _tr),
        ),
        subtitle: Text(
          "11/11/11",
          style: TextStyle(color: _tr),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    Size screen = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: _tr,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          Text("Tambah absensi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 10),
          Divider(
            height: 2,
            thickness: 2,
            endIndent: 10,
            indent: 10,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                currentTime: DateTime.now(),
                minTime: DateTime(2019, 1, 1),
                maxTime: DateTime(2021, 12, 31),
                locale: LocaleType.id,
                onConfirm: (time) {
                  _setDate(time);
                },
              );
            },
            child: Container(
              width: screen.width * 0.9,
              decoration: BoxDecoration(
                  color: _sec,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: TextField(
                controller: _tanggalController,
                enabled: false,
                style: TextStyle(color: _tr),
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.yellow,
                    fontSize: 11,
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today_rounded,
                    color: _tr,
                  ),
                  labelText: "Tanggal",
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: _tr),
                  focusColor: _tr,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: screen.width * 0.9,
            decoration: BoxDecoration(
                color: _sec,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: _kelasController,
              style: TextStyle(color: _tr),
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.yellow,
                  fontSize: 11,
                ),
                prefixIcon: Icon(
                  Icons.meeting_room_rounded,
                  color: _tr,
                ),
                labelText: "Kelas",
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
                labelStyle: TextStyle(color: _tr),
                focusColor: _tr,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: screen.width * 0.9,
            decoration: BoxDecoration(
                color: _sec,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              controller: _pelajaran,
              style: TextStyle(color: _tr),
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.yellow,
                  fontSize: 11,
                ),
                prefixIcon: Icon(
                  Icons.class__rounded,
                  color: _tr,
                ),
                labelText: "Mata pelajaran",
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
                labelStyle: TextStyle(color: _tr),
                focusColor: _tr,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
              height: screen.height * 0.08,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.cyan],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: screen.width * 0.9,
              child: Center(
                child: Text("Tambah absensi",
                    style: GoogleFonts.redressed(
                        color: _tr, fontSize: 20, fontWeight: FontWeight.bold)),
              )),
        ],
      ),
    );
  }
}
