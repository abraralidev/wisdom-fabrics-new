import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Screens/Home/home.dart';
import 'package:wisdomfabrics/Screens/SignUp/signup.dart';
import 'package:wisdomfabrics/Screens/SplashScreen/splash.dart';
import 'package:wisdomfabrics/Screens/wishlist/wishlist_screen.dart';
import 'package:wisdomfabrics/Widgets/accountheader.dart';
import 'package:wisdomfabrics/Widgets/accountlisttile.dart';
import 'package:wisdomfabrics/Widgets/orangedivider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../OrderHistory/orderhistory.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinUser = UserModel.fromMap(value.data());
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;

// Delete the user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor('62CDFF'),
                  HexColor('62CDFF'),
                  HexColor('C9EEFF'),
                  HexColor('00008B'),
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                elevation: 0,
                pinned: true,
                backgroundColor: Colors.white,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        duration: const Duration(
                          microseconds: 200,
                        ),
                        child: const Text(
                          'Account',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              HexColor('62CDFF'),
                              HexColor('62CDFF'),
                              HexColor('C9EEFF'),
                              HexColor('00008B'),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            left: 30,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  'assets/guest.jpg',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 26.0),
                                child: Text(
                                  '${loggedinUser.firstname}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          const ProfileHeader(
                            labeltext: ' Account Info, ',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 1.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      title: const Text('Email Address'),
                                      subtitle: Text('${loggedinUser.email}'),
                                      leading: const Icon(
                                        Icons.mail,
                                      ),
                                    ),
                                  ),
                                  const RedDivider(),
                                  AccountRepeatedListTile(
                                    title: 'Order History',
                                    subtitle: '',
                                    onTap: () {
                                      Get.to(() => OrderHistory());
                                    },
                                    icon: Icons.location_pin,
                                  ),
                                  const RedDivider(),
                                  AccountRepeatedListTile(
                                    title: 'Edit Profile',
                                    subtitle: '',
                                    onTap: () {},
                                    icon: Icons.edit,
                                  ),
                                  const RedDivider(),
                                  AccountRepeatedListTile(
                                    title: 'Change Password',
                                    subtitle: '',
                                    onTap: () {},
                                    icon: Icons.lock,
                                  ),
                                  const RedDivider(),
                                  AccountRepeatedListTile(
                                    title: 'My Wishlist',
                                    subtitle: '',
                                    onTap: () {
                                      Get.to(() => WishListScreen());
                                    },
                                    icon: Icons.bookmark,
                                  ),
                                  const RedDivider(),
                                  AccountRepeatedListTile(
                                    title: 'Log Out',
                                    subtitle: '',
                                    onTap: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen(),
                                        ),
                                      );
                                    },
                                    icon: Icons.logout,
                                  ),
                                  const RedDivider(),
                                  AccountRepeatedListTile(
                                    title: 'Delete Account',
                                    subtitle: '',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Delete Account',
                                            ),
                                            content: const Text(
                                              'Are you sure you want to delete your account?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await user!
                                                      .delete()
                                                      .then((value) {
                                                    Fluttertoast.showToast(
                                                        msg: 'User Deleted');
                                                  }).catchError((error) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Error deleting user: $error");
                                                    print(
                                                        "Error deleting user: $error");
                                                  });
                                                  // and also delete from firestore
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(user!.uid)
                                                      .delete()
                                                      .then((value) {
                                                    Fluttertoast.showToast(
                                                        msg: 'User Deleted');
                                                  }).catchError((error) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Error deleting user from firestore: $error");
                                                    print(
                                                        "Error deleting user from firestore: $error");
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SplashScreen(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Delete',
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
