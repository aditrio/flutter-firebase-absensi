import 'package:eabsensi_firebase/models/absen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'package:page_transition/page_transition.dart';

class GuruPage extends StatefulWidget {
  @override
  _GuruPageState createState() => _GuruPageState();
}

class _GuruPageState extends State<GuruPage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Color _bg = Color(0xff1d3557);
  Color _sec = Color(0xff457b9d);
  Color _tr = Color(0xfff1faee);

  TextEditingController _tanggalController = new TextEditingController();
  TextEditingController _kelasController = new TextEditingController();
  TextEditingController _pelajaran = new TextEditingController();

  _setDate(value) {
    setState(() {
      _tanggalController.text = DateFormat('yyyy-MM-dd').format(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _tanggalController.text = '';
    _kelasController.text = '';
    _tanggalController.text = '';
  }

  _cleanText() {
    _tanggalController.text = '';
    _kelasController.text = '';
    _pelajaran.text = '';
  }

  _deleteData(id) {
    _database.reference().child('/absensi/' + id).remove();
  }

  _update(data, status) {
    _tanggalController.text = data.value['tanggal'];
    _kelasController.text = data.value['kelas'];
    _pelajaran.text = data.value['mapel'];
    _showModal(status, data.value['absen_id']);
  }

  _detailModal(data) {
    showModalBottomSheet(
        barrierColor: Colors.black45,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => _detailBottomSheet(data.value));
  }

  _showModal(status, id) {
    showModalBottomSheet(
        barrierColor: Colors.black45,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => _bottomSheet(status, id));
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cleanText();
          _showModal("create", null);
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
                              Container(
                                child: FirebaseAnimatedList(
                                    shrinkWrap: true,
                                    query: _database
                                        .reference()
                                        .child('/absensi/'),
                                    itemBuilder: (BuildContext context,
                                        DataSnapshot snapshot,
                                        Animation<double> anim,
                                        int index) {
                                      return Slidable(
                                        actionExtentRatio: 0.2,
                                        closeOnScroll: true,
                                        actionPane: SlidableDrawerActionPane(),
                                        child: _absenWidget(snapshot, index),
                                        secondaryActions: [
                                          IconSlideAction(
                                            caption: 'Edit',
                                            color: Colors.blue,
                                            icon: Icons.edit_attributes_rounded,
                                            onTap: () {
                                              _update(snapshot, "update");
                                            },
                                          ),
                                          IconSlideAction(
                                            caption: 'Delete',
                                            color: Colors.red,
                                            icon: Icons.delete_forever_rounded,
                                            onTap: () {
                                              _deleteData(
                                                  snapshot.value['absen_id']);
                                            },
                                          ),
                                        ],
                                      );
                                    }),
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

  Widget _absenWidget(data, index) {
    return GestureDetector(
      onTap: () => _detailModal(data),
      child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: _sec, borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _tr,
              child: Center(child: Text((index + 1).toString())),
            ),
            title: Text(
              data.value['kelas'],
              style: TextStyle(color: _tr),
            ),
            subtitle: Text(
              data.value['mapel'],
              style: TextStyle(color: _tr),
            ),
            trailing: Text(
              data.value['tanggal'],
              style: TextStyle(color: _tr),
            ),
          )),
    );
  }

  Widget _bottomSheet(status, id) {
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
          GestureDetector(
            onTap: () {
              if (status != "update") {
                Absen _absen = new Absen(
                    _database.reference().child('/absensi/').push().key,
                    _tanggalController.text,
                    _kelasController.text,
                    _pelajaran.text,
                    "belum ada");

                _database
                    .reference()
                    .child('/absensi/' + _absen.absen_id)
                    .set(_absen.toJson());
                Navigator.pop(context);
              } else {
                Absen _absen = new Absen(id, _tanggalController.text,
                    _kelasController.text, _pelajaran.text, "belum ada");

                _database
                    .reference()
                    .child('/absensi/' + id)
                    .update(_absen.toJson());
                Navigator.pop(context);
              }
            },
            child: Container(
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
                          color: _tr,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                )),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _detailBottomSheet(data) {
    return Container(
      decoration: BoxDecoration(
          color: _tr, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Detail absensi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 10),
          Divider(
            height: 2,
            thickness: 2,
            endIndent: 10,
            indent: 10,
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text("Kelas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(data['kelas']),
              Divider(
                thickness: 1.5,
                indent: 40,
                endIndent: 40,
              ),
              Text("Mata pelajaran",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(data['mapel']),
              Divider(
                thickness: 1.5,
                indent: 40,
                endIndent: 40,
              ),
              Text("Tanggal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(data['tanggal']),
              Divider(
                thickness: 1.5,
                indent: 40,
                endIndent: 40,
              ),
              Text("Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(data['status']),
              Divider(
                thickness: 1.5,
                indent: 40,
                endIndent: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
