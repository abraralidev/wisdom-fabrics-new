// ignore_for_file: camel_case_types, file_names, avoid_print, unused_local_variable, use_rethrow_when_possible, prefer_const_constructors, use_build_context_synchronously, unused_field, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Page/page.dart';
import 'package:wisdomfabrics/Screens/SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({Key? key}) : super(key: key);

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'firstName': user.displayName,
            'uid': user.uid,
            'email': user.email,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );

      res = false;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    //--------------------------------Email
    final emailFeild = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Email");
        }
        String pattern = r'\w+@\w+\.\w+';
        if (!RegExp(pattern).hasMatch(value)) {
          return 'Invalid Email format';
        }
        return null;
      },
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //------------------------------Password
    final passwordFeild = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordcontroller,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter Password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Password(Min 6 character)");
        }
        return null;
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //--------------------------------Button
    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: HexColor('62CDFF'),
      child: MaterialButton(
        splashColor: Colors.black,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (emailcontroller.text.contains('admin@gmail.com') &&
              passwordcontroller.text.contains('iamadmin')) {
            print('Admin');
          }
          if (_formKey.currentState!.validate()) {
            setState(() {
              email = emailcontroller.text;
              password = passwordcontroller.text;
            });
            userLogin();
          }
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/e2.png",
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    emailFeild,
                    const SizedBox(
                      height: 30,
                    ),
                    passwordFeild,
                    const SizedBox(
                      height: 35,
                    ),
                    loginbutton,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Sign_Up(),
                              ),
                            );
                          },
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: HexColor('62CDFF'),
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor('62CDFF'),
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        foregroundColor: Colors.white,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width - 70, 50),
                      ),
                      onPressed: () async {
                        bool res = await signInWithGoogle(context);
                        if (res) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => Pagescreen()));
                        }
                      },
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 18,
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

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Pagescreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor('C9EEFF'),
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor('C9EEFF'),
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }
}

class UserModel {
  String? uid;
  String? email;
  String? firstname;

  UserModel({
    this.uid,
    this.email,
    this.firstname,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstName'],
    );
  }

//sending
  Map<String, dynamic> tomap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstname,
    };
  }
}
