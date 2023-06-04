// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ebookapp/Screens/SignUp/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class DummyScreen extends StatefulWidget {
//   const DummyScreen({super.key});

//   @override
//   State<DummyScreen> createState() => _DummyScreenState();
// }

// class _DummyScreenState extends State<DummyScreen> {

//   final TextEditingController firstnameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextFormField(
//       autofocus: false,
//       obscureText: true,
//       controller: firstnameController,
//       onSaved: (value) {
//         firstnameController.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: "Text",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     ),
//       ),
//     );
//   }

// }