// ignore_for_file: prefer_const_constructors, unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './writerHome.dart';
import 'home.dart';
//import 'package:email_validator/email_validator.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  // void initState() {
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() {
  //     print("completed");
  //     setState(() {});
  //   });
  // }

  //FirebaseAuth fireauth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _Key = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
    usernameController.dispose();
    nameController.dispose();
  }

  bool obscure_text = true;
  Icon iconfirst = Icon(
    Icons.visibility_off,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //SafeArea(
          Container(
        alignment: Alignment.center,
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
                  Text(
                    "تسجيل حساب جديد",
                    style: TextStyle(
                        fontSize: 33.0,
                        color: Color.fromARGB(255, 29, 22, 13),
                        fontWeight: FontWeight.bold,
                        fontFamily: "ElMessiri"),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                  ),

                  //------------------------------الاسم---------------------------------------
                  SizedBox(
                    height: 3.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
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

                  Container(
                    //مربع الاسم
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        ////////// validator /////////////
                        if (value!.isEmpty) {
                          return 'يجب ادخال الاسم';
                        } else if (value.contains('0-9')) {
                          return 'الاسم غير صالح';
                        } else
                          return null;
                      },
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                  ),
                  //------------------------
                  SizedBox(
                    height: 9.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
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
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextFormField(
                      controller: ageController,
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                  ),
                  //--------------------اسم المستخدم-----------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
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
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        ////////// validator /////////////
                        if (value!.isEmpty) {
                          return 'يجب ادخال اسم المستخدم';
                        } else if (value.contains('0')) {
                          // اشيك في الداتابيس
                          return 'اسم المستخدم محجوز';
                        } else
                          return null;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                  ),
                  //-----------------------------البريد الالكتروني----------------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
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
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                          return "Enter Correct Email Address";
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.right,
                      cursorColor: Color(0xFF90B28D),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Color(0xFF90B28D),
                        ),
                        hintText: "البريد الإلكتروني",
                        hintStyle: TextStyle(
                          color: Color(0xFF909A99),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  //-------------------------------كلمة المرور------------------------------
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
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
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        ////////// validator /////////////
                        if (value!.isEmpty) {
                          return 'يجب ادخال كلمة مرور';
                        } else if (value.length < 8) {
                          return 'كلمة المرور يجب ان تحتوي على 8 خانات';
                          //} else if (!value.contains('a-z') &&
                          //    !value.contains('0-9')) {
                          //  return 'كلمة المرور يجب ان تحتوي على أرقام وحروف';
                        } else
                          return null;
                      },
                      textAlign: TextAlign.right,
                      obscureText: obscure_text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
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
                        //hintText: "كلمة المرور",
                        //hintStyle: TextStyle(
                        //  color: Color(0xFF909A99),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      register(
                          emailController.text.trim(), passwordController.text);
                    },
                    child: Text(
                      'تسجيل',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Tajawal'),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey;
                        }
                        return Colors.orange;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  //////////////////////////////////////// have an account
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: SignPage,
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
    );
  }

  SignPage() {
    print("done");
  }

  void register(String email, String password) async {
    if (_Key.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()});
      } on FirebaseAuthException catch (e) {
        print(e);
        Map<String, String?> codeResponses = {
          // Re-auth responses
          "user-mismatch": 'المستخدم غير متطابق',
          "user-not-found": 'لم يتم العثور على المستخدم',
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
                  content: Text(codeResponses[e.code]!),
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

  postDetailsToFirestore() async {
    User? user = _auth.currentUser;
        double age = double.parse(ageController.text);


    await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
      'userID': user?.uid,
      'name': nameController.text,
      'age': ageController.text,
      'username': usernameController.text,
      'email': emailController.text,
    });
    print("Yeeeeeeeeeeeeeees");

    if (age >= 60) {
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => writerHome()),
          (route) => false);
    } else if (age < 60) {
      Navigator.pushAndRemoveUntil((context),
          MaterialPageRoute(builder: (context) => home()), (route) => false);
    }
  }
}
