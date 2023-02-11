import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toto/BottomNavBar.dart';
import 'package:toto/readerNavBar.dart';
//import 'package:toto/loggin.dart';
import './forgetpassword.dart';
//import 'package:intl/intl.dart';
import './CreateAccount.dart';
import './home.dart';
//import 'utils/utils/assets.dart';
import 'TaleedApp.dart';
import 'User.dart';
import 'assets.dart';
import 'writerHome.dart';

class login extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<login> {
  bool obscure_text = true;
  Icon iconfirst = Icon(
    Icons.visibility_off,
    color: Color.fromARGB(255, 255, 255, 255),
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var user = FirebaseAuth.instance.currentUser!;
  final numericRegex = RegExp(r'[0-9]');
  final CharRegex = RegExp(r'[!@#\$&*~]');
  final LetterRegex = RegExp(r'[a-z A-Z]');
  late QuerySnapshot userr1;
  var myList = [];
  bool test = false;
  bool writer = false;
  var errorMessage = '';

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

  // get snapshot => null;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "تسجيل دخول",
                      style: TextStyle(
                          fontSize: 35.0,
                          color: Color.fromARGB(255, 67, 63, 54),
                          fontWeight: FontWeight.bold,
                          fontFamily: "ElMessiri"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    ),
//---------------------------------email-------------------------------------
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
//---------------------------------password-------------------------------------
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
                          color: Assets.shared.iconColor,
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (obscure_text == true) {
                                obscure_text = false;
                                iconfirst = Icon(
                                  Icons.visibility,
                                  color: Color.fromARGB(255, 93, 125, 90),
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
                          color: Assets.shared.hintColor,
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      width: 280,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => forgetpass(),
                              ));
                        },
                        style: ButtonStyle(
                          alignment: Alignment.topLeft,
                        ),
                        child: Text(
                          " نسيت كلمة المرور",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "ElMessiri",
                              fontSize: 12.0,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                    ),
                    //-------------------------------------the button--------------------
                    ElevatedButton(
                      onPressed: logIn,
                      // child: StreamBuilder<User?>(
                      //   stream: FirebaseAuth.instance.authStateChanges(),
                      //   builder: (context, snapshot) {
                      //     // try{
                      //     print('inside bulder method');
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //       // } else if (snapshot.hasError) {
                      //       //   print("dont have acc");

                      //       //   return Text('has error');
                      //     }
                      //     if (snapshot.hasData) {
                      //       print('have account');
                      //       return home();
                      //     } else {
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //           content: const Text('Invalid email/password'),
                      //           backgroundColor: Colors.red.shade400,
                      //           margin: const EdgeInsets.fromLTRB(6, 0, 3, 0),
                      //           behavior: SnackBarBehavior.floating,
                      //           action: SnackBarAction(
                      //             label: 'Dismiss',
                      //             disabledTextColor: Colors.white,
                      //             textColor: Colors.white,
                      //             onPressed: () {},
                      //           )));
                      //       return Text('there is something error');
                      //     }
                      //     //checkIn(context, snapshot);
                      //   },
                      // ),
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
                        "تسجيل دخول",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "ElMessiri",
                            fontSize: 20.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    //----------------------dont have account---------------
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
                                    builder: (context) => CreateAccount(),
                                  ));
                            },
                            style: ButtonStyle(
                              alignment: Alignment.center,
                            ),
                            child: Text(
                              "تسجيل جديد",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ElMessiri",
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          Text(
                            "ليس لديك حساب؟",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "ElMessiri",
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ]))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
  }

  // void login() {}

  Future<void> logIn() async {
    print('inside login method');
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        //////////////////check age//////////////////

        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((userData) {
          var userAge = userData.data()!['age'];
          print('userAge');
          print(userAge);
          double uAge = double.parse(userAge);

////////////retrieves and saves the current users information 
          FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        setState(() {
          TaleedApp.loggedInUser = UserModel.fromMap(value.data());
        });
      });
///////////////////////////////////////////////////////
          if (uAge >= 60) {
            print("in writer");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => navBar()));
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("!مرحبًا بك مجددًا"),
                actions: [
                  TextButton(
                      child: Text("حسنًا"),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            );
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => readerNavBar()));
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("!مرحبًا بك مجددًا"),
                actions: [
                  TextButton(
                      child: Text("حسنًا"),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            );
          }
        });

        print('end try');
      } catch (e) {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('البريد الإكتروني/كلمة السر خاطئة'),
              backgroundColor: Colors.red.shade400,
              margin: const EdgeInsets.fromLTRB(6, 0, 3, 0),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'إخفاء',
                disabledTextColor: Colors.white,
                textColor: Colors.white,
                onPressed: () {},
              )));
          print("after check");
        }
      }
    } else if (emailController.text.isEmpty &&
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('رجاءًً.. أدخل بياناتك بشكلٍ صحيح'),
          backgroundColor: Colors.red.shade400,
          margin: const EdgeInsets.fromLTRB(6, 0, 3, 0),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'إخفاء',
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            onPressed: () {},
          )));
      print("after check2");
    }

    // Future<void> checkIn(
    //     BuildContext context, AsyncSnapshot<User?> snapshot) async {
    //   print('inside bulder method');
    //   try {
    //     if (snapshot.hasData) {
    //       print('have account');
    //       //return home();
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => home(),
    //           ));
    //     }
    //   } catch (e) {
    //     print("dont have acc");
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => login(),
    //         ));
    //     // return login();
    //   }
    // }
  }
}
