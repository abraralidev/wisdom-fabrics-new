import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdomfabrics/Screens/Chapter/chap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key, required this.id});
  final String id;
  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

final CollectionReference _book =
    FirebaseFirestore.instance.collection('books');

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "فہرست",
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.notoNastaliqUrdu(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: _book
                        .doc(widget.id)
                        .collection('chap')
                        .orderBy('num', descending: false)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 5,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    topic1(
                                      id: widget.id,
                                      index: index,
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 6,
                                    ),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          documentSnapshot['num'],
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          documentSnapshot['title'],
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: GoogleFonts.notoNastaliqUrdu(
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: Image.asset(
                          'assets/g.gif',
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
