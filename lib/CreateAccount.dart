// ignore_for_file: prefer_const_constructors, unused_element
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toto/BottomNavBar.dart';
import 'package:toto/login.dart';
import 'package:toto/main.dart';
import 'package:toto/readerNavBar.dart';
import 'TaleedApp.dart';
import 'User.dart';
import 'assets.dart';
import 'home.dart';
import 'login.dart';

//import 'package:email_validator/email_validator.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _auth = FirebaseAuth.instance;
  final _Key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final numericRegex = RegExp(r'[0-9]');
  final CharRegex = RegExp(r'[!@#\$&*~]');
  final LetterRegex = RegExp(r'[a-z A-Z]');
  bool isVisible = false;
  var errorMessage = '';
  //late Stream<QuerySnapshot> _readUsers;
  bool userexist = false;

  String? validateName(String? formName) {
    final nameRegex = RegExp(
        r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z][\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z\s_-]{1,20}$');

    if (formName == null || formName.isEmpty)
      return 'الاسم مطلوب';
    else if (!nameRegex.hasMatch(formName))
      return 'يجب أن يتكون الاسم من حروف فقط';
    else
      return null;
  }

  Future<bool> registerUsername(String username) async {
    var readUsers;
    readUsers = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: '$username')
        .get();
    return await readUsers.docs.isEmpty ? false : true;
  }

  String? validateUserName(String? formUserName) {
    if (formUserName == null || formUserName.isEmpty)
      return 'اسم المستخدم مطلوب';
    else if (userexist)
      return 'اسم المستخدم مستخدم مسبقًا';
    else
      return null;
  }

  String? validateAge(String? formAge) {
    if (formAge == null || formAge.isEmpty)
      return 'العمر مطلوب';
    else
      return null;
  }

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

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty)
      return 'كلمة المرور مطلوبة';
    else if (formPassword.length < 8)
      return 'يجب ان تحتوي كلمة المرور على 8 خانات أو أكثر';
    else if (!numericRegex.hasMatch(formPassword) &&
        !LetterRegex.hasMatch(formPassword))
      return 'يجب أن تحتوي كلمة المرور على أرقام وحروف';
    else
      return null;
  }
////////////////////////////////////////////////////////////////////////////////

  bool obscure_text = true;
  Icon iconfirst = Icon(
    Icons.visibility_off,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        body:
            //SafeArea(
            Container(
          alignment: Alignment.center,

          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35.0),
          //padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/housebg.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _Key,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .07,
                    ),
                    Text(
                      "تسجيل حساب جديد",
                      style: TextStyle(
                          fontSize: 33.0,
                          color: Color.fromARGB(255, 67, 63, 54),
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri"),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    ),

                    //------------------------------name---------------------------------------
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        "الاسم",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "ElMessiri",
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 34, 75, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    TextFormField(
                      controller: nameController,
                      validator: validateName,
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
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
                          Icons.person,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "الاسم",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                    ),

                    //------------------------age---------------------
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        "العمر",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "ElMessiri",
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 34, 75, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    TextFormField(
                      controller: ageController,
                      validator: validateAge,
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
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
                          Icons.calendar_month,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "العمر",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    //------------------------Username-----------------------------
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        "اسم المستخدم",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "ElMessiri",
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 34, 75, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: usernameController,
                      validator: validateUserName,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.9),
                        filled: true,
                        counterText: "",
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
                          Icons.account_box,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "اسم المستخدم",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                    ),

                    //---------------------------Email----------------------------------
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
                          color: Color.fromARGB(255, 34, 75, 12),
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
                          color: Color(0xFF90B28D),
                        ),
                        hintText: 'email@address.com',
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    //-------------------------------Password------------------------------
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        "كلمة المرور",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "ElMessiri",
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 34, 75, 12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    TextFormField(
                      controller: passwordController,
                      validator: validatePassword,
                      textAlign: TextAlign.right,
                      obscureText: obscure_text,
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
                          Icons.lock,
                          color: Color(0xFF90B28D),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (obscure_text == true) {
                                obscure_text = false;
                                iconfirst = Icon(
                                  Icons.visibility,
                                  color: Color(0xFF90B28D),
                                );
                              } else {
                                obscure_text = true;
                                iconfirst = Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey.shade300,
                                );
                              }
                            });
                          },
                          child: iconfirst,
                        ),
                        hintText: "كلمة المرور",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        register(emailController.text.trim(),
                            passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(280, 40),
                          backgroundColor: Assets.shared.RedColor,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          )),
                      child: Text(
                        "تسجيل ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "ElMessiri",
                            fontSize: 22.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    //////////////////////////////////////// have an account
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => login(),
                                    ));
                              },
                              style: ButtonStyle(
                                alignment: Alignment.center,
                              ),
                              child: Text(
                                "تسجيل دخول",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ElMessiri",
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            Text(
                              "لديك حساب؟",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ElMessiri",
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register(String email, String password) async {
    if (_Key.currentState!.validate()) {
      bool usernameoo = await registerUsername(usernameController.text);
      if (usernameoo) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Expanded(
              child: AlertDialog(
                content: Text('اسم المستخدم مستخدم مسبقًا'),
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
      } else {
        try {
          await _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => {postDetailsToFirestore()});
        } on FirebaseAuthException catch (error) {
          print(error);
          errorMessage = error.message!;
          Map<String, String?> codeResponses = {
            // Re-auth responses
            "user-mismatch": 'المستخدم غير متطابق',
            "user-not-found": 'لم يتم العثور على المستخدم',
            "email-already-in-use": 'البريد الالكتروني مستخدم مسبقًا',
            "invalid-credential": 'invalid credential',
            "invalid-email": 'الايميل غير موجود',
            "wrong-password": 'كلمة المرور الحالية خاطئة',
            "invalid-verification-code": 'رمز التحقق غير صالح',
            "invalid-verification-id": 'معرّف التحقق غير صالح',
            "user-disabled": 'المستخدم لهذا الايميل معطّل',
            "too-many-requests": 'طلبات كثيرة',
            "operation-not-allowed":
                'تسجيل الدخول من خلال الايميل وكلمة المرور غير مسموح',
            // Update password error codes
            "weak-password": 'كلمة المرور غير قوية',
            "requires-recent-login": 'يتطلب تسجيل دخول حديث'
          };
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text(codeResponses[error.code] ?? "Unknown error"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'حسنًا'),
                        child: const Text('حسنًا'),
                      )
                    ]);
              });
        }
      }
    }
  }

  postDetailsToFirestore() async {
    User? user = _auth.currentUser;
    double age = double.parse(ageController.text);

    try {
      await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        'userID': user?.uid,
        'name': nameController.text,
        'age': ageController.text,
        'username': usernameController.text,
        'email': emailController.text,
      });
      ////////////////////////add to log in before going to home page
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          TaleedApp.loggedInUser = UserModel.fromMap(value.data());
        });
      });
      ///////////////////////////////////////////////////////////
      if (age >= 60) {
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => navBar()),
            (route) => false);
      } else if (age < 60) {
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => readerNavBar()),
            (route) => false);
      }
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message!;
    }
  }
}
