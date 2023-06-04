// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Screens/Description/desc.dart';
import 'package:wisdomfabrics/Screens/SeeAll/see.dart';
import 'package:wisdomfabrics/Screens/cate/cat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final CollectionReference _book =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference _catt =
      FirebaseFirestore.instance.collection('category');
  final _catqueryUnstitch = FirebaseFirestore.instance
      .collection('Products')
      .where('category', arrayContains: 'Unstitch');
  final _catqueryStitch = FirebaseFirestore.instance
      .collection('Products')
      .where('category', arrayContains: 'Stitch');
  // Biography
  final _catquerygents = FirebaseFirestore.instance
      .collection('Products')
      .where('category', arrayContains: 'gents');
  // Safarnama
  final _catqueryaccessories = FirebaseFirestore.instance
      .collection('Products')
      .where('category', arrayContains: 'accessories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                expandedHeight: 444,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        duration: const Duration(
                          microseconds: 200,
                        ),
                        child: const Text(
                          'Wisdom Fabrics',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      background: SizedBox(
                        child: Stack(
                          children: [
                            Container(
                              height: 375,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                    50,
                                  ),
                                ),
                                color: HexColor('62CDFF'),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 17.0,
                                      bottom: 16,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Wisdom Fabrics'.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 28,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: TextFormField(
                                      autofocus: false,
                                      controller: firstnameController,
                                      onSaved: (value) {
                                        firstnameController.text = value!;
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        filled: true,
                                        suffixIcon: const Icon(
                                          Icons.search,
                                        ),
                                        fillColor: HexColor('C9EEFF'),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                18, 8, 18, 8),
                                        hintText: "Search for Products",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "Most Popular",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        InkWell(
                                          child: Text(
                                            "See All",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 275,
                                  ),
                                  SizedBox(
                                    height: 185,
                                    child: StreamBuilder(
                                      stream: _book
                                          .where('paid', isEqualTo: true)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              streamSnapshot) {
                                        if (streamSnapshot.hasData) {
                                          return ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics: const PageScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                top: 8, bottom: 0),
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              final DocumentSnapshot
                                                  documentSnapshot =
                                                  streamSnapshot
                                                      .data!.docs[index];
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DescriptionPage(
                                                        img: documentSnapshot[
                                                            'images'],
                                                        price: documentSnapshot[
                                                            'price'],
                                                        id: documentSnapshot.id,
                                                        eng: documentSnapshot[
                                                            'title'],
                                                        desc: documentSnapshot[
                                                            'des'],
                                                        buy: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Card(
                                                        elevation: 7,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: HexColor(
                                                                'C9EEFF'),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              width: 5,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                documentSnapshot[
                                                                    'images'],
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          height: 200,
                                                          width: 100,
                                                          child:
                                                              const SizedBox(),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 18,
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          SizedBox(
                                                            height: 50,
                                                            width: 110,
                                                            child: Text(
                                                              documentSnapshot[
                                                                  'title'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 6,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: HexColor('62CDFF'),
                                        ));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Stitch",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SeeAll(
                                    buy: true,
                                    title: "Stitch",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 275,
                      child: StreamBuilder(
                        stream: _catqueryStitch
                            .where('paid', isEqualTo: true)
                            .snapshots(),
                        // _book.orderBy('tc', descending: true).snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DescriptionPage(
                                          img: documentSnapshot['images'],
                                          price: documentSnapshot['price'],
                                          id: documentSnapshot.id,
                                          eng: documentSnapshot['title'],
                                          desc: documentSnapshot['des'],
                                          buy: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor('C9EEFF'),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                documentSnapshot['images'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 185,
                                          width: 125,
                                          child: const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 130,
                                        child: Center(
                                          child: Text(
                                            documentSnapshot['title'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                              child: CircularProgressIndicator(
                            color: HexColor('62CDFF'),
                          ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "gents",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SeeAll(
                                    buy: true,
                                    title: "gents",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 275,
                      child: StreamBuilder(
                        stream: _catquerygents
                            .where('paid', isEqualTo: true)
                            .snapshots(),
                        // _book.orderBy('tc', descending: true).snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DescriptionPage(
                                          img: documentSnapshot['images'],
                                          price: documentSnapshot['price'],
                                          id: documentSnapshot.id,
                                          eng: documentSnapshot['title'],
                                          desc: documentSnapshot['des'],
                                          buy: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor('C9EEFF'),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                documentSnapshot['images'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 185,
                                          width: 125,
                                          child: const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 130,
                                        child: Center(
                                          child: Text(
                                            documentSnapshot['title'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: HexColor('62CDFF'),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Unstitch",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SeeAll(
                                    buy: true,
                                    title: "Unstitch",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 275,
                      child: StreamBuilder(
                        stream: _catqueryUnstitch
                            .where('paid', isEqualTo: true)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DescriptionPage(
                                          img: documentSnapshot['images'],
                                          price: documentSnapshot['price'],
                                          id: documentSnapshot.id,
                                          eng: documentSnapshot['title'],
                                          desc: documentSnapshot['des'],
                                          buy: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor('C9EEFF'),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                documentSnapshot['images'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 185,
                                          width: 125,
                                          child: const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 130,
                                        child: Center(
                                          child: Text(
                                            documentSnapshot['title'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: HexColor('62CDFF'),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Products",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Catscreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "See All",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 250,
                      child: StreamBuilder(
                        stream: _catt.snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                          if (streamSnapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => paidSeeAll(
                                          title: documentSnapshot['name'],
                                          buy: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Card(
                                        elevation: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor('C9EEFF'),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                documentSnapshot['icon'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 185,
                                          width: 125,
                                          child: const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                        height: 35,
                                        width: 130,
                                        child: Center(
                                          child: Text(
                                            documentSnapshot['name'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                              child: CircularProgressIndicator(
                            color: HexColor(
                              '62CDFF',
                            ),
                          ));
                        },
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
