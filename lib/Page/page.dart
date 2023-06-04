import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Screens/Cart/cart.dart';
import 'package:wisdomfabrics/Screens/Catalog/catalog.dart';
import 'package:wisdomfabrics/Screens/Home/home.dart';
import 'package:wisdomfabrics/Screens/Library/lib.dart';
import 'package:wisdomfabrics/Screens/Profile/p.dart';
import 'package:wisdomfabrics/Screens/SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Pagescreen extends StatefulWidget {
  const Pagescreen({super.key});

  @override
  State<Pagescreen> createState() => _PagescreenState();
}

class _PagescreenState extends State<Pagescreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CatalogScreen(),
    LibraryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  int? total;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedinUser = UserModel();

  int? getbadge() {
    var respectsQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('cart');
    respectsQuery.get().then((data) {
      int totalb = data.docs.length;
      setState(() {
        total = totalb;
      });
      return totalb;
    });
    return total;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedinUser = UserModel.fromMap(value.data());
      getbadge;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book_sharp,
              ),
              label: 'Catalog',
              backgroundColor: Colors.white),
          const BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Library',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Badge(
              backgroundColor: HexColor('62CDFF'),
              label:
                  getbadge() == null ? const Text('0') : Text(total.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
            backgroundColor: Colors.white,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor('62CDFF'),
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
