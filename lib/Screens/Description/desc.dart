// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Screens/Cart/cart.dart';
import 'package:wisdomfabrics/Screens/Index/index.dart';
import 'package:wisdomfabrics/Screens/SignUp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({
    super.key,
    required this.img,
    required this.price,
    required this.id,
    required this.eng,
    required this.desc,
    required this.buy,
  });
  final String img;
  final String price;
  final String id;
  final String eng;

  final bool buy;

  final String desc;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool cart = false;
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

  @override
  Widget build(BuildContext context) {
    return cart
        ? Scaffold(
            body: widget.buy
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 530,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/bg.jpeg',
                                  ),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                                child: const SizedBox(),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 62,
                                  ),
                                  Card(
                                    elevation: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor('C9EEFF'),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 5,
                                          color: Colors.white,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.img,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 260,
                                      width: 180,
                                      child: const SizedBox(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.eng,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.notoNastaliqUrdu(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 24,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          height: 33,
                                          color: Colors.white,
                                          width: 3,
                                          child: const SizedBox(),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          height: 33,
                                          color: Colors.white,
                                          width: 3,
                                          child: const SizedBox(),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 10,
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                heroTag: null,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              right: 10,
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartScreen(),
                                    ),
                                  );
                                },
                                heroTag: null,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: Badge(
                                  backgroundColor: HexColor('62CDFF'),
                                  label: getbadge() == null
                                      ? const Text('0')
                                      : Text(total.toString()),
                                  child: const Icon(Icons.shopping_cart),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 1,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  fixedSize: const Size(
                                    140,
                                    40,
                                  ),
                                ),
                                child: const Text(
                                  'Wishlist Now',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.desc.replaceAll("\\n", "\n"),
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 530,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/bg.jpeg',
                                  ),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                                child: const SizedBox(),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 62,
                                  ),
                                  Card(
                                    elevation: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor('C9EEFF'),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 5,
                                          color: Colors.white,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.img,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 260,
                                      width: 180,
                                      child: const SizedBox(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.eng,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.notoNastaliqUrdu(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 10,
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                heroTag: null,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              right: 10,
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartScreen(),
                                    ),
                                  );
                                },
                                heroTag: null,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: Badge(
                                  backgroundColor: HexColor('62CDFF'),
                                  label: getbadge() == null
                                      ? const Text('0')
                                      : Text(total.toString()),
                                  child: const Icon(Icons.shopping_cart),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IndexScreen(
                                        id: widget.id,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 1,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  fixedSize: const Size(
                                    140,
                                    40,
                                  ),
                                ),
                                child: const Text(
                                  'Read Now',
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 1,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  fixedSize: const Size(
                                    140,
                                    40,
                                  ),
                                ),
                                child: const Text(
                                  'Wishlist Now',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.desc.replaceAll("\\n", "\n"),
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
            bottomSheet: widget.buy
                ? Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RedButton(
                          onPress: () async {
                            uploadcart();
                          },
                          label: 'Buy Now: ${widget.price}/-',
                          width: MediaQuery.of(context).size.width * 0.60,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          )
        : Scaffold(
            body: widget.buy
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 530,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/bg.jpeg',
                                  ),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                                child: const SizedBox(),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 62,
                                  ),
                                  Card(
                                    elevation: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor('C9EEFF'),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 5,
                                          color: Colors.white,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.img,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 260,
                                      width: 180,
                                      child: const SizedBox(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.eng,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.notoNastaliqUrdu(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 10,
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                heroTag: null,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  uploadwishlist();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 1,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  fixedSize: const Size(
                                    140,
                                    40,
                                  ),
                                ),
                                child: const Text(
                                  'Wishlist Now',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.desc.replaceAll("\\n", "\n"),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 530,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/bg.jpeg',
                                  ),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                                child: const SizedBox(),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 62,
                                  ),
                                  Card(
                                    elevation: 7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor('C9EEFF'),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          width: 5,
                                          color: Colors.white,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.img,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 260,
                                      width: 180,
                                      child: const SizedBox(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.eng,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '',
                                    textDirection: TextDirection.rtl,
                                    style: GoogleFonts.notoNastaliqUrdu(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 24,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: const [
                                            Text(
                                              "Language ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white60,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Urdu",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Container(
                                          height: 33,
                                          color: Colors.white,
                                          width: 3,
                                          child: const SizedBox(),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            const Text(
                                              "50%",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            LinearPercentIndicator(
                                              width: 120.0,
                                              lineHeight: 12.0,
                                              percent: 0.5,
                                              animation: true,
                                              linearStrokeCap:
                                                  LinearStrokeCap.roundAll,
                                              animationDuration: 3000,
                                              backgroundColor: Colors.grey,
                                              progressColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 10,
                              child: FloatingActionButton.small(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                heroTag: null,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IndexScreen(
                                        id: widget.id,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 1,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  fixedSize: const Size(
                                    140,
                                    40,
                                  ),
                                ),
                                child: const Text(
                                  'Read Now',
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  uploadwishlist();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 1,
                                  side: const BorderSide(
                                    color: Colors.black,
                                  ),
                                  fixedSize: const Size(
                                    140,
                                    40,
                                  ),
                                ),
                                child: const Text(
                                  'Wishlist Now',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            widget.desc.replaceAll("\\n", "\n"),
                            style: GoogleFonts.notoNastaliqUrdu(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
            bottomSheet: widget.buy
                ? Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RedButton(
                          onPress: () async {
                            uploadcart();
                            uploadhistory();
                          },
                          label: 'Buy Now: ${widget.price}/-',
                          width: MediaQuery.of(context).size.width * 0.60,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          );
  }

  uploadcart() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final firebaseref = firebaseFirestore
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('cart')
        .doc(widget.id);

    await firebaseref.set({
      'img': widget.img,
      'name': widget.eng,
      'pic': widget.price,
    });
    Fluttertoast.showToast(msg: 'Added to cart');
    getbadge();
    setState(() {
      cart = true;
    });
  }

  uploadhistory() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final firebaseref = firebaseFirestore
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('orderhistory')
        .doc(widget.id);

    await firebaseref.set({
      'img': widget.img,
      'name': widget.eng,
      'pic': widget.price,
      'status': 'Pending'
    });
  }

  uploadwishlist() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final firebaseref = firebaseFirestore
        .collection('users')
        .doc(loggedinUser.uid)
        .collection('wishlist')
        .doc(widget.id);

    await firebaseref.set({
      'img': widget.img,
      'name': widget.eng,
    });

    Fluttertoast.showToast(msg: 'Added to wishlist');
  }
}

class RedButton extends StatelessWidget {
  final String label;
  final Function() onPress;
  final double width;
  const RedButton({
    Key? key,
    required this.label,
    required this.onPress,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
