import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'utils/utils/assets.dart';
import 'assets.dart';
//import './main.dart';

class forgetpass extends StatefulWidget {
  @override
  _forgetpassState createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _Key2 = GlobalKey<FormState>();

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty)
      return 'البريد الالكتروني مطلوب';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail))
      return 'صيغة البريد الالكتروني غير صحيحة';
    else
      return null;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,

          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),

          //padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/housebg.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _Key2,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Text(
                      "  نسيت كلمة المرور",
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Color.fromARGB(255, 67, 63, 54),
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    ),
                    Space(70.0),

                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        "البريد الإلكتروني",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "ElMessiri",
                          fontSize: 16.0,
                          color: Assets.shared.Gcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateEmail,
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.9),
                        counterText: "",
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Assets.shared.iconColor,
                        ),
                        hintText: 'email@address.com',
                        hintStyle: TextStyle(
                          color: Assets.shared.hintColor,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
                    //   child: Text(
                    //     "البريد الالكتروني",
                    //     textAlign: TextAlign.right,
                    //     style: TextStyle(
                    //       fontFamily: "ElMessiri",
                    //       fontSize: 21.0,
                    //       color: Color.fromARGB(255, 34, 75, 12),
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 50.0,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   margin:
                    //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    //   child: TextField(
                    //     textAlign: TextAlign.right,
                    //     cursorColor: Color(0xFF90B28D),
                    //     decoration: InputDecoration(
                    //       border: InputBorder.none,
                    //       suffixIcon: Icon(
                    //         Icons.phone_android,
                    //         color: Color(0xFF90B28D),
                    //       ),
                    //       hintText: "البريد الالكتروني",
                    //       hintStyle: TextStyle(
                    //         color: Color(0xFF909A99),
                    //       ),
                    //     ),
                    //     keyboardType: TextInputType.phone,
                    //   ),
                    // ),
                    // Space(250.0),
                    // ElevatedButton(
                    //   onPressed: forgetPass(),
                    //   style: ElevatedButton.styleFrom(
                    //       fixedSize: Size(280, 40),
                    //       backgroundColor: Color(0xFFA03C1B),
                    //       elevation: 0.0,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(30),
                    //         ),
                    //       )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    ),
                    Space(250.0),
                    ElevatedButton(
                      onPressed: () async {
                        forgetPass(emailController.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(280, 40),
                          //backgroundColor: Assets.shared.RedColor,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          )),
                      child: Text(
                        "استمرار ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "ElMessiri",
                            fontSize: 20.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //   ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Space(double px) {
    return SizedBox(
      height: px,
    );
  }

  forgetPass(String email) async {
    _Key2.currentState!.validate();
    if (validateEmail(email) == null) {
      final _auth1 = FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (_auth1 != null) {
        try {
          await _auth.sendPasswordResetEmail(
              email: emailController.text.trim());

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  content: Text('تم ارسال رابط تعديل كلمة المرور على بريدك'),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      child: const Text('حسنًا'),
                    )
                  ],
                ),
              );
            },
          );
        } on FirebaseException catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  content: Text('لا يوجد حساب مسجل بهذا البريد'),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      child: const Text('حسنًا'),
                    )
                  ],
                ),
              );
            },
          );
          print(e);
        }
      }

      // else {
      // print('hh');
      // }
    }
  }
}
