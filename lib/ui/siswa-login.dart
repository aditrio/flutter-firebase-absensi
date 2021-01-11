import 'package:eabsensi_firebase/ui/siswa.dart';
import 'package:eabsensi_firebase/ui/validation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginSiswa extends StatefulWidget {
  @override
  _LoginSiswaState createState() => _LoginSiswaState();
}

class _LoginSiswaState extends State<LoginSiswa> with Validation {
  Color _bg = Color(0xff1d3557);
  Color _sec = Color(0xff457b9d);
  Color _tr = Color(0xfff1faee);

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // clearField() {
  //   _emailController.clear();
  //   _passController.clear();
  // }

  String _email;
  String _pass;

  final email = "siswa1@gmail.com";
  final pass = "12345678";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = '';
    _pass = '';

    //_formKey.currentState.reset();
  }

  clearField() {
    setState(() {
      _emailController.clear();
      _passController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
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
                      height: screen.height * 0.25,
                      child: Center(
                        child: Text(
                          "Login Siswa",
                          textAlign: TextAlign.center,
                          style:
                              GoogleFonts.redressed(fontSize: 35, color: _tr),
                        ),
                      ),
                    ),
                    Container(
                      width: screen.width,
                      height: screen.height * 0.45,
                      margin: EdgeInsets.all(35),
                      decoration: BoxDecoration(
                          color: _tr,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          )),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: _sec,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: screen.width * 0.7,
                                child: TextFormField(
                                  controller: _emailController,
                                  validator: emailValidation,
                                  onSaved: (value) {
                                    _email = value;
                                    value = '';
                                  },
                                  style: TextStyle(color: _tr),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 11,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_rounded,
                                      color: _tr,
                                    ),
                                    labelText: "Email",
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(color: _tr),
                                    focusColor: _tr,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: _sec,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: screen.width * 0.7,
                                child: TextFormField(
                                  enableSuggestions: false,
                                  obscureText: true,
                                  controller: _passController,
                                  validator: passValidation,
                                  onSaved: (value) {
                                    _pass = value;
                                    value = '';
                                  },
                                  style: TextStyle(color: _tr),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 11,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: _tr,
                                    ),
                                    labelText: "Password",
                                    contentPadding: EdgeInsets.all(10),
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(color: _tr),
                                    focusColor: _tr,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    //_formKey.currentState.reset();

                                    if (_emailController.text == email &&
                                        _passController.text == pass) {
                                      clearField();

                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: SiswaPage(),
                                              type: PageTransitionType.fade));
                                    } else {
                                      _scaffoldKey.currentState
                                          .showSnackBar(_showSnackbar());
                                      clearField();
                                    }
                                  }
                                },
                                child: Container(
                                    height: screen.height * 0.08,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Colors.blue, Colors.cyan],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    width: screen.width * 0.7,
                                    child: Center(
                                      child: Text("Login",
                                          style: GoogleFonts.redressed(
                                              color: _tr,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    )),
                              )
                            ],
                          )),
                    ),
                    Center(
                      child: Text(
                        "e-absensi v.0.1 ",
                        style: TextStyle(color: _tr),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _showSnackbar() {
    return SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Email atau Password anda salah !"),
        action: SnackBarAction(
          label: "Tutup",
          onPressed: () => SnackBarClosedReason.dismiss,
        ));
  }
}
