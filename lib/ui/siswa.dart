import 'package:eabsensi_firebase/models/absen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class SiswaPage extends StatefulWidget {
  @override
  _SiswaPageState createState() => _SiswaPageState();
}

class _SiswaPageState extends State<SiswaPage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Color _bg = Color(0xff1d3557);
  Color _sec = Color(0xff457b9d);
  Color _tr = Color(0xfff1faee);

  _updateStatus(data, status) {
    Absen absen = new Absen(data.value['absen_id'], data.value['tanggal'],
        data.value['kelas'], data.value['mapel'], status);

    _database
        .reference()
        .child('/absensi/' + data.value['absen_id'])
        .update(absen.toJson());
  }

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
          Column(
            children: [
              Container(
                height: screen.height * 0.2,
                child: Center(
                  child: Text("Absensi",
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
                                  query:
                                      _database.reference().child('/absensi/'),
                                  itemBuilder: (BuildContext context,
                                      DataSnapshot snapshot,
                                      Animation<double> anim,
                                      int index) {
                                    return snapshot.value['status'] ==
                                            "belum ada"
                                        ? Slidable(
                                            actionExtentRatio: 0.2,
                                            closeOnScroll: true,
                                            actionPane:
                                                SlidableDrawerActionPane(),
                                            child:
                                                _absenWidget(snapshot, index),
                                            secondaryActions: [
                                              IconSlideAction(
                                                caption: 'Hadir',
                                                color: Colors.green,
                                                icon: Icons.book_rounded,
                                                onTap: () => _updateStatus(
                                                    snapshot, "Hadir"),
                                              ),
                                              IconSlideAction(
                                                caption: 'Sakit',
                                                color: Colors.grey,
                                                icon: Icons
                                                    .local_pharmacy_rounded,
                                                onTap: () => _updateStatus(
                                                    snapshot, "Sakit"),
                                              ),
                                              IconSlideAction(
                                                caption: 'Izin',
                                                color: Colors.purple,
                                                icon: Icons.warning_rounded,
                                                onTap: () => _updateStatus(
                                                    snapshot, "Izin"),
                                              ),
                                            ],
                                          )
                                        : Container();
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
    );
  }

  Widget _absenWidget(data, index) {
    return Container(
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
        ));
  }
}
