// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously, unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Page/page.dart';
import 'package:wisdomfabrics/Screens/Payment/payment.dart';
import 'package:wisdomfabrics/Screens/SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nite = TextEditingController();
  final TextEditingController statepasswordController = TextEditingController();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    //--------------------------------First Name
    final firstnamefeild = TextFormField(
      autofocus: false,
      controller: nameController,
      onSaved: (value) {
        nameController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Name");
        }

        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //--------------------------------Last Name
    final lastnamefeild = TextFormField(
      autofocus: false,
      controller: addressController,
      onSaved: (value) {
        addressController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Address");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_on),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Address",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //--------------------------------Email
    final emailfeild = TextFormField(
      autofocus: false,
      controller: numController,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        numController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Phone number");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //--------------------------------Password
    final passwordfeild = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: cityController,
      onSaved: (value) {
        cityController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter City");
        }

        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "City",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //--------------------------------Confirm Password
    final confirmpassword = TextFormField(
      autofocus: false,
      controller: statepasswordController,
      onSaved: (value) {
        statepasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "State",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final notespassword = TextFormField(
      autofocus: false,
      maxLines: 7,
      controller: nite,
      onSaved: (value) {
        nite.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.text_fields),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Notes",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    //--------------------------------Button
    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: HexColor('62CDFF'),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          uploadcart();
          // uploadorderhistory();
        },
        child: const Text(
          "Order Placed",
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
      body: load
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : Center(
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
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              'CHECKOUT',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: HexColor('62CDFF'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          firstnamefeild,
                          const SizedBox(
                            height: 15,
                          ),
                          lastnamefeild,
                          const SizedBox(
                            height: 15,
                          ),
                          emailfeild,
                          const SizedBox(
                            height: 15,
                          ),
                          passwordfeild,
                          const SizedBox(
                            height: 15,
                          ),
                          confirmpassword,
                          const SizedBox(
                            height: 15,
                          ),
                          notespassword,
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // add total price of order

                          loginbutton,
                          const SizedBox(
                            height: 12,
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

  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  UserModel loggedinUser = UserModel();
  uploadcart() async {
    setState(() {
      load == !load;
    });
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final firebaseref = firebaseFirestore.collection('orders').doc();
    int calculateTotalPrice(List<QueryDocumentSnapshot> docs) {
      int totalPrice = 0;
      for (var doc in docs) {
        totalPrice += int.parse(doc['pic'] as String);
      }
      return totalPrice;
    }

    QuerySnapshot snaphsots = await firebaseFirestore
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('cart')
        .get();

    await firebaseref.set(
      {
        'name': nameController.text,
        'city': cityController.text,
        'address': addressController.text,
        'state': statepasswordController.text,
        'note': nite.text,
        'number': numController.text,
        'uid': loggedinUser.uid,
        'date':
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        'time':
            "${DateTime.now().hour % 12}:${DateTime.now().minute} ${DateTime.now().hour < 12 ? 'AM' : 'PM'}",
        // Total price
        'totalPrice': calculateTotalPrice(snaphsots.docs),
        'status': 'Pending',
      },
    );
    QuerySnapshot snaphsot = await firebaseFirestore
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('cart')
        .get();

    for (var message in snaphsot.docs) {
      final img = message['img'];
      final name = message['name'];
      final pic = message['pic'];

      firebaseFirestore
          .collection('orders')
          .doc(firebaseref.id)
          .collection('pro')
          .add({'img': img, 'name': name, 'pic': pic});
    }

    var collection = FirebaseFirestore.instance
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('cart');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: HexColor('62CDFF'),
        content: const Text(
          'Order Confirmed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
    Get.offAll(
      const Pagescreen(),
    );
  }

  // uploadorderhistory() async {
  //   setState(() {
  //     load == !load;
  //   });
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   final firebaseref = firebaseFirestore.collection('orderhistory').doc();
  //   int calculateTotalPrice(List<QueryDocumentSnapshot> docs) {
  //     int totalPrice = 0;
  //     for (var doc in docs) {
  //       totalPrice += int.parse(doc['pic'] as String);
  //     }
  //     return totalPrice;
  //   }

  //   QuerySnapshot snaphsots = await firebaseFirestore
  //       .collection('users')
  //       .doc(loggedinUser.uid)
  //       .collection('orderhistory')
  //       .get();

  //   await firebaseref.set(
  //     {
  //       'name': nameController.text,
  //       'city': cityController.text,
  //       'address': addressController.text,
  //       'state': statepasswordController.text,
  //       'note': nite.text,
  //       'number': nameController.text,
  //       'uid': loggedinUser.uid,
  //       'date':
  //           "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
  //       'time': "${DateTime.now().hour}:${DateTime.now().minute}",
  //       // Total price
  //       'totalPrice': calculateTotalPrice(snaphsots.docs),
  //       'status': 'Pending',
  //     },
  //   );
  //   QuerySnapshot snaphsot = await firebaseFirestore
  //       .collection('users')
  //       .doc(loggedinUser.uid)
  //       .collection('orderhistory')
  //       .get();

  //   for (var message in snaphsot.docs) {
  //     final img = message['img'];
  //     final name = message['name'];
  //     final pic = message['pic'];

  //     firebaseFirestore
  //         .collection('orderhistory')
  //         .doc(firebaseref.id)
  //         .collection('pro')
  //         .add({'img': img, 'name': name, 'pic': pic});
  //   }
  //   uploadoderhistory() async {
  //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //     final firebaseref = firebaseFirestore
  //         .collection('users')
  //         .doc(loggedinUser.uid)
  //         .collection('orderhistory')
  //         .doc();
  //     for (var message in snaphsot.docs) {
  //       final img = message['img'];
  //       final name = message['name'];
  //       final pic = message['pic'];
  //       await firebaseref.set({
  //         'img': img,
  //         'name': name,
  //         'pic': pic,
  //       });
  //       firebaseFirestore
  //           .collection('orderhistory')
  //           .doc(firebaseref.id)
  //           .collection('pro')
  //           .add({'img': img, 'name': name, 'pic': pic});
  //     }
  //   }
  //   // var collection = FirebaseFirestore.instance
  //   //     .collection('users')
  //   //     .doc(loggedinUser.uid)

  //   Get.offAll(
  //     const Pagescreen(),
  //   );
  // }
}
