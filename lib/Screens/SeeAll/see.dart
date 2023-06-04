// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Description/desc.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key, required this.title, required this.buy});
  final String title;
  final bool buy;
  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    final _book = FirebaseFirestore.instance
        .collection('Products')
        .where('category', arrayContains: widget.title)
        .where("paid", isEqualTo: true);
    return StreamBuilder(
      stream: _book.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            body: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 2 / 3.5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (BuildContext ctx, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return widget.buy
                    ? InkWell(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                      documentSnapshot['images'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: 185,
                                width: 140,
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
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(
                                  14,
                                ),
                              ),
                              height: 32,
                              width: 105,
                              child: Center(
                                child: Text(
                                  'PKR: ${documentSnapshot['price']}/-',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                      documentSnapshot['images'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: 185,
                                width: 140,
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
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      );
              },
            ),
          );
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
    );
  }
}

class paidSeeAll extends StatefulWidget {
  const paidSeeAll({super.key, required this.title, required this.buy});
  final String title;
  final bool buy;
  @override
  State<paidSeeAll> createState() => _paidSeeAllState();
}

class _paidSeeAllState extends State<paidSeeAll> {
  @override
  Widget build(BuildContext context) {
    final _book = FirebaseFirestore.instance
        .collection('Products')
        .where('category', arrayContains: widget.title);
    return widget.buy
        ? StreamBuilder(
            stream: _book
                .where(
                  "paid",
                  isEqualTo: true,
                )
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    elevation: 1,
                  ),
                  body: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2 / 3.5,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return widget.buy
                          ? InkWell(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                                            documentSnapshot['images'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 185,
                                      width: 140,
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
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                        14,
                                      ),
                                    ),
                                    height: 32,
                                    width: 105,
                                    child: Center(
                                      child: Text(
                                        'PKR: ${documentSnapshot['price']}/-',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : InkWell(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                                            documentSnapshot['images'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 185,
                                      width: 140,
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
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
          )
        : StreamBuilder(
            stream: _book
                .where(
                  "paid",
                  isEqualTo: true,
                )
                .orderBy('tc', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      widget.title,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 1,
                  ),
                  body: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2 / 3.5,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return widget.buy
                          ? InkWell(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                                            documentSnapshot['images'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 185,
                                      width: 140,
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
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(
                                        14,
                                      ),
                                    ),
                                    height: 32,
                                    width: 105,
                                    child: Center(
                                      child: Text(
                                        'PKR: ${documentSnapshot['price']}/-',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : InkWell(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                                            documentSnapshot['images'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 185,
                                      width: 140,
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
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            },
          );
  }
}
